class ProductsController < ApplicationController

    def index
      @products = Product.all
    end

    def new
      @product = Product.new
    end

    def create
      @product = current_user.products.new(product_params.merge(status: 'unapproved'))

      if @product.save
        redirect_to root_path, notice: 'product was successfully created.'
      else
        render :new
      end
    end

    private


    def product_params
      params.require(:product).permit(:name, :description,  :minimum_bid_amount, :user_id)
    end
end

