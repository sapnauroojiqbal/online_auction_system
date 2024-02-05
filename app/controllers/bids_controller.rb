class BidsController < ApplicationController
  before_action :set_bid, except: %i[index new create]
    def index
      @bids = Bid.all
    end

    def new
      @bid = Bid.new
    end

    def show
    end

    def create
      @bid = Bid.new(bid_params)
      if @bid.save
        redirect_to auctions_path, notice: 'bid was successfully created.'
      else
        render :new
      end
    end

    def destroy
      if @bid.destroy
        redirect_to auctions_path, notice: 'bid Deleted Successfully'
      else
        redirect_to auctions_path, alert: 'bid not Deleted'
      end
    end

    def edit
    end

    def update
      if @bid.update(bid_params)
        redirect_to auctions_path, notice: 'bid successfully updated!'
      else
        render 'edit', alert: 'bid not updated!'
      end
    end

    private

    def set_bid
      @bid = Bid.find_by(id: params[:id])
      redirect_to bids_path, alert: 'bid Not Found' if @bid.nil?
    end

    def bid_params
      params.require(:bid).permit(:amount, :user_id, :product_id)
    end
end
