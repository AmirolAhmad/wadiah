class DashboardsController < ApplicationController
  before_action :authenticate_user!
  before_filter :admin_only

  def index
    @orders = Order.all
    @payments = Payment.all
    @users = User.all
  end
end
