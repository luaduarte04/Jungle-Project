class Admin::DashboardController < ApplicationController
  def show
    @category = Category.all
    @products = Product.all
  end
end
