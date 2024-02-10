# frozen_string_literal: true

class UserMailer < ApplicationMailer
  def welcome_email
    @user = params[:user]
    @password = params[:password]

    mail(to: @user.email, subject: 'Welcome to Auctioneer App!')
  end
end
