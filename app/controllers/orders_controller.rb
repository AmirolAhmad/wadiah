class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_filter :set_user, only: [:index, :new, :create, :show]
  before_filter :user_only

  def index
    @orders = Order.where(user_id: @user)
  end

  def new
    @order ||= Order.new
    render
  end

  def create
    @order = @user.orders.new(order_params)
    if @order.save
      redirect_to orders_path, notice: "Awesome! New order has been submit!"
    else
      render 'new'
    end
  end

  private

    def set_user
      @user = current_user
    end

    def order_params
      params.require(:order).permit(:order_number, :quantity, :total_price, :status)
    end
end
