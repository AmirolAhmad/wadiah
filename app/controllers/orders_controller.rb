class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_filter :user_only

  def index
    @orders = Order.all
  end

  def new
    
  end
end
