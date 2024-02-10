# frozen_string_literal: true

class ProductsController < ApplicationController
  before_action :authorize_resource, except: %i[index show]
  before_action :set_product, except: %i[index new create]

  def index
    if current_user.buyer?
      @user_products = Product.where(sold_to_id: current_user.id)
    elsif current_user.seller?
      @user_products = Product.where(user_id: current_user.id)
    end
    @products = Product.all

    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  def new
    @product = Product.new
  end

  def show; end

  def create
    @product = current_user.products.new(product_params.merge(status: 'unapproved'))

    respond_to do |format|
      if @product.save
        format.html { redirect_to product_path(@product), notice: 'product was successfully created.' }
        format.turbo_stream
      else
        format.html { render :new }
      end
    end
  end

  def destroy
    @product.destroy

    respond_to do |format|
      format.html { redirect_to products_path, notice: 'Product Deleted Successfully' }
      format.turbo_stream { render turbo_stream: turbo_stream.remove(@product) }
    end
  end

  def edit; end

  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to product_path(@product), notice: 'Product successfully updated!' }
        format.turbo_stream { render turbo_stream: turbo_stream.update(@product) }
      else
        format.html { render 'edit', alert: 'Product not updated!' }
      end
    end
  end

  def change_status
    respond_to do |format|
      if @product.update(status: params[:status])
        format.turbo_stream { render turbo_stream: turbo_stream.update(@product) }
        format.html { redirect_to products_path, notice: 'Status updated successfully.' }
      else
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace('flash', partial: 'shared/flash',
                                                             locals: { message: 'Something went wrong', type: 'danger' })
        end
        format.html { redirect_to products_path, alert: 'Something went wrong' }
      end
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
    params.require(:product).permit(:name, :description, :minimum_bid_amount, :user_id, :preview_image, :auction_id,
                                    :status, { images: [] })
  end
end
