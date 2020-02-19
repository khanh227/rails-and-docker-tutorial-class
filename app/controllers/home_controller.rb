class HomeController < ApplicationController
  def index
    @products = Product.enabled
  end
end
