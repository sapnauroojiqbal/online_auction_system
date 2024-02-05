class ReviewsController < ApplicationController
  before_action :authenticate_user!

  def new
    @review = Review.new
    @seller = User.find(params[:seller_id])
    @product = Product.find(params[:product_id])
  end

  def create
    @review = Review.new(review_params)
    @seller = User.find(params[:review][:seller_id])
    @product = Product.find(params[:review][:product_id])

    if @review.save
      redirect_to @product, notice: 'Review was successfully created.'
    else
      render :new
    end
  end

  private

  def review_params
    params.require(:review).permit(:content, :rating, :seller_id, :product_id).merge(
      buyer_id: current_user.id
    )
  end

end
