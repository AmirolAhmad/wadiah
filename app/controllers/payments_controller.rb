class PaymentsController < ApplicationController
  before_action :authenticate_user!
  before_filter :set_user, only: [:index, :new, :create, :show]
  before_filter :user_only

  def index
    @payments = Payment.where(user_id: @user)
  end

  def new
    @payment ||= Payment.new
    render
  end

  def create
    @payment = @user.payments.new(payment_params)
    if @payment.save
      redirect_to payments_path, notice: "Awesome! Payment has been submitted for review!"
    else
      render 'new'
    end
  end

  def show
    
  end

  private

    def set_user
      @user = current_user
    end

    def payment_params
      params.require(:payment).permit(:order_id, :payment_method, :payment_date, :payment_time, :reference_number, :total_payment, :attachment, :receipt_number)
    end
end
