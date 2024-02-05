class ProductsController < ApplicationController
  before_action :authorize_resource, except: %i[index show create]
  before_action :set_product, except: %i[index new create]
  def index
    if current_user.buyer?
      @user_products = Product.where(:sold_to_id => current_user.id)
    elsif current_user.seller?
      @user_products = Product.where(:user_id => current_user.id)
    else
    end
    @products = Product.all
  end

    def new
      @product = Product.new
    end

    def show
    end

    def create
      @product = current_user.products.new(product_params.merge(status: 'unapproved'))
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
      if @product.update(status: params[:status])
      redirect_to products_path, notice: 'Status updated successfully.'
      else
        flash[:danger] = 'Something went wrong'
      end
    end

    private

    def authorize_resource
      authorize! params[:action.to_sym], Product
    end

    def set_product
      @product = Product.find_by(id: params[:id])
      redirect_to products_path, alert: 'Product Not Found' if @product.nil?
    end

    def product_params
      params.require(:product).permit(:name, :description, :minimum_bid_amount, :user_id, :preview_image, :auction_id, :status, { images: [] })
    end
end

