class AuctionsController < ApplicationController
  before_action :set_auction, except: %i[index new create]
    def index
      @auctions = Auction.all
    end

    def new
      @auction = Auction.new
    end

    def show
    end

    def create
      @auction = current_user.auctions.new(auction_params.merge(status: 'approved'))
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
      @auction.update(status: params[:status])
      flash[:success] = 'Status updated successfully.'
    end

    private

    def set_auction
      @auction = Auction.find_by(id: params[:id])
      redirect_to auctions_path, alert: 'Auction Not Found' if @auction.nil?
    end

    def auction_params
      params.require(:auction).permit(:)
    end
end
