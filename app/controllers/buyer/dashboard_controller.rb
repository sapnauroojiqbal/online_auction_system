class Buyer::DashboardController < ApplicationController
  layout 'buyer'

  def index
    @products = Product.all
  end

  def add_admins
    # Logic to manage admins
  end

  def change_role
    @user = User.find(params[:id])
    @user.update(role: params[:role])
    flash[:success] = 'Role updated successfully.'
    redirect_to root_path
  end

  def product_report

  end

  def auction_results

  end

  def modify_users_and_products
  end

end
