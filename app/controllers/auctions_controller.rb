class AuctionsController < ApplicationController
  before_action :authorize_resource, except: %i[index show create]
  before_action :set_auction, except: %i[index new create]
    def index
      @auctions = Auction.all
      @available_products = Product.where(user_id: current_user.id, status: "approved")
    end

    def new
      @auction = Auction.new
    end

    def show
      @auction = Auction.find_by(id: params[:id])

      if @auction
        render 'show'
      else
        flash[:error] = 'Auction not found.'
        redirect_to root_path  # Adjust the redirect path based on your application's needs
      end
    end

    def create
      @auction = current_user.auctions.new(auction_params.merge(status: 'unapproved'))
      if @auction.save
        redirect_to auctions_path, notice: 'auction was successfully created.'
      else
        render :new
      end
    end

    def destroy
      if @auction.destroy
        redirect_to auctions_path, notice: 'Auction Deleted Successfully'
      else
        redirect_to auctions_path, alert: 'Auction not Deleted'
      end
    end

    def edit
    end

    def update
      if @auction.update(auction_params)
        redirect_to auction_path(@auction), notice: 'Auction successfully updated!'
      else
        render 'edit', alert: 'Auction not updated!'
      end
    end

    def change_status
      if @auction.update(status: params[:status])
      redirect_to auctions_path, notice: 'Status updated successfully.'
      else
        flash[:danger] = 'Something went wrong'
      end
    end

    def add_products_to_auction
      @auction = Auction.find_by(id: params[:id])
      @available_products = Product.where(user_id: current_user.id, status: "approved")
    end

    def assign_products_to_auction
      @auction = Auction.find_by(id: params[:id])
      selected_product_ids = params[:product][:product_ids]
      selected_products = Product.where(id: selected_product_ids)

      selected_products.update_all(auction_id: @auction.id)
      @auction.products.update_all(status: Product.statuses[:live])

      redirect_to auctions_path, notice: "Products added to auction successfully."
    end

    private

    def authorize_resource
      authorize! params[:action.to_sym], Auction
    end

    def set_auction
      @auction = Auction.find_by(id: params[:id])
      redirect_to auctions_path, alert: 'Auction Not Found' if @auction.nil?
    end

    def auction_params
      params.require(:auction).permit(:start_time, :end_time, :minimum_bids,:status, :user_id)
    end
end
