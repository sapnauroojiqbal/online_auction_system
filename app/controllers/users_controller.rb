# frozen_string_literal: true
class UsersController < ApplicationController
  before_action :authorized_user, only: %i[destroy index]

  def index
    @users = User.where.not(id: current_user.id).where.not(user_type: :super_admin)
  end

  def show
    @user = User.find_by(id: params[:id])
    redirect_to root_url, alert: 'No record Found' if @user.nil?
  end

  def new
    @user = User.new
  end

  def  add_admin
    @user = User.new
  end

  def create_admin
    @user = User.new(admin_params.merge(user_type: :admin))
    if current_user.super_admin?
      if @user.save
        UserMailer.with(user: @user, password: params[:user][:password]).welcome_email.deliver_now
        redirect_to users_path, notice: 'User was successfully created.'
      else
        flash.now[:alert] = @user.errors.full_messages.join("<br/>")
        render :add_admin
      end
    else
      redirect_to users_path, alert: 'Unauthorized: Only super admin can create admin users.'
    end
  end

  def change_user_role
      @user = User.find_by(id: params[:id])
      @user.update(user_type: params[:user_type])
      flash.now[:success] = 'Role updated successfully.'
  end

  def destroy
    @user = User.find_by(id: params[:id])

    if @user
      if current_user.super_admin?
        if @user.destroy
          redirect_to users_url, notice: 'User deleted successfully.'
        else
          redirect_to users_url, alert: 'Failed to delete user.'
        end
      else
        redirect_to users_url, alert: 'Unauthorized: Only super admin can delete users.'
      end
    else
      redirect_to users_url, alert: 'User not found.'
    end
  end

  private

  def logged_in_user
    redirect_to login_url, alert: 'Please log in.' unless logged_in?
  end

  def authorized_user
    unless current_user.admin? || current_user.super_admin?
      redirect_to root_url, alert: 'Unauthorized: Only admin is authorized for this action.'
    end
  end

  def admin_params
    params.require(:user).permit(:email, :password,  :current_password,:avatar, :first_name, :last_name, :phone_number, :address, :gender, :user_type)
  end
end
