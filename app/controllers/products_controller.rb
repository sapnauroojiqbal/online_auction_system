class ProductsController < ApplicationController
  before_action :set_product, except: %i[index new create]
    def index
      @products = Product.all
    end

    def new
      @product = Product.new
    end

    def show
    end

    def create
      @product = current_user.products.new(product_params.merge(status: 'approved'))
      if @product.save
        redirect_to products_path, notice: 'product was successfully created.'
      else
        render :new
      end
    end

    def destroy
      if @product.destroy
        redirect_to products_path, notice: 'Product Deleted Successfully'
      else
        redirect_to products_path, alert: 'Product not Deleted'
      end
    end

    def edit
    end

    def update
      if @product.update(product_params)
        redirect_to product_path(@product), notice: 'Product successfully updated!'
      else
        render 'edit', alert: 'Product not updated!'
      end
    end

    def change_status
      @product.update(status: params[:status])
      flash[:success] = 'Status updated successfully.'
    end

    private

    def set_product
      @product = Product.find_by(id: params[:id])
      redirect_to products_path, alert: 'Product Not Found' if @product.nil?
    end

    def product_params
      params.require(:product).permit(:name, :description, :minimum_bid_amount, :user_id, { images: [] }, :preview_image, :status)
    end
end

