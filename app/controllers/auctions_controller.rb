# frozen_string_literal: true
class AuctionsController < ApplicationController
  before_action :authorize_resource, except:%i[index show]
  before_action :set_auction, except: %i[index new create]
  before_action :available_products, only: %i[index show assign_products_to_auction]

    def index
      @auctions = Auction.all
    end

    def new
      @auction = Auction.new
    end

    def show
      if @auction
        render 'show'
      else
        flash.now[:error] = @auction.errors.full_messages.join('<br>')
        redirect_to root_path
      end
    end

    def create
      @auction = current_user.auctions.new(auction_params.merge(status: 'unapproved'))
      if @auction.save
        redirect_to auctions_path, notice: 'auction was successfully created.'
      else
        redirect_to auctions_path
        flash.now[:alert] = @auction.errors.full_messages.join('<br>')
      end
    end

    def destroy
      if @auction.destroy
        redirect_to auctions_path
        flash.now[:notice]= 'Auction Deleted Successfully'
      else
        redirect_to auctions_path
        flash.now[:alert] =@auction.errors.full_messages.join('<br>')
      end
    end

    def edit
    end

    def update
      if @auction.update(auction_params)
        flash.now[:notice] = 'Auction successfully updated!'
        redirect_to auction_path(@auction)
      else
        flas.now[:alert] = @auction.errors.full_messages.join('<br>')
        render 'edit'
      end
    end

    def change_status
      if @auction.update(status: params[:status])
      render json: { message: 'Status updated successfully.' }, status: :ok
      else
        render json: { error: @auction.errors.full_messages.join }
        flash.now[:danger] = @auction.errors.full_messages.join('<br>')
      end
    end

    def assign_products_to_auction
      @auction = Auction.find_by(id: params[:id])
      selected_product_ids = params[:product][:product_ids]
      selected_products = Product.where(id: selected_product_ids)

      selected_products.update_all(auction_id: @auction.id)
      @auction.products.update_all(status: Product.statuses[:live])

      redirect_to auctions_path
       flash.now[:notice]= "Products added to auction successfully."
    end

    private

    def authorize_resource
      authorize! params[:action.to_sym], Auction
    end

    def set_auction
      @auction = Auction.find_by(id: params[:id])
      redirect_to auctions_path, alert: 'Auction Not Found' if @auction.nil?
    end

    def available_products
      @available_products = Product.where(user_id: current_user.id, status: "approved")
    end

    def auction_params
      params.require(:auction).permit(:start_time, :end_time, :minimum_bids,:status, :user_id)
    end
end
