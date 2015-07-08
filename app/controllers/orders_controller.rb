class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_filter :set_user, only: [:index, :new, :create]
  before_filter :user_only, only: [:index, :new, :create]
  before_filter :admin_only, only: [:set_cancelled, :set_pending]

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
      redirect_to orders_path, notice: "Awesome! New order has been submit and pending until you settle the payment! Please check your email for the payment instructions."
    else
      render 'new'
    end
  end

  def set_cancelled
    @order = Order.find(params[:id])
    @order.update_attributes(status: "Cancel")
    redirect_to dashboard_path
  end

  def set_pending
    @order = Order.find(params[:id])
    @order.update_attributes(status: "Pending")
    redirect_to dashboard_path
  end

  private

    def set_user
      @user = current_user
    end

    def order_params
      params.require(:order).permit(:order_number, :quantity, :total_price, :status)
    end
end
