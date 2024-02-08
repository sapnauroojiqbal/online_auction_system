# frozen_string_literal: true
class WelcomeController < ApplicationController
  def index
    @products = Product.all
  end
end
