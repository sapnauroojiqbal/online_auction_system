class ReviewsController < ApplicationController
  before_action :authenticate_user!

  def new
    @review = Review.new
    @seller = User.find(params[:seller_id])
    @product = Product.find(params[:product_id])
  end

  def create
    @review = Review.new(review_params)
    @seller = User.find(params[:seller_id])
    @product = Product.find(params[:product_id])

    if @review.save
      redirect_to @product, notice: 'Review was successfully created.'
    else
      redirect_to products_path, alert: @review.errors.full_messages.join(' <br />')
    end
  end

  private

  def review_params
    params.permit(:content, :rating, :seller_id, :product_id).merge(buyer_id: current_user.id)
  end

end
