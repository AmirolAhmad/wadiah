class PaymentsController < ApplicationController
  before_action :authenticate_user!
  before_filter :set_user, only: [:index, :new, :create, :show]
  before_filter :user_only, only: [:index, :new, :create]
  before_filter :admin_only, only: [:set_pending, :set_accepted, :set_rejected]

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
      redirect_to payments_path, notice: "Awesome! Payment has been submitted for review! An admin will respond to your payment shortly."
    else
      render 'new'
    end
  end

  def show
    @payment = Payment.find(params[:id])
    if @payment
      render
    else
      if !current_user.is_admin?
        redirect_to payments_path, notice: "Oops! Payment not found!"
      else
        redirect_to dashboard_path, notice: "Oops! Payment not found!"
      end
    end
  end

  def set_pending
    @payment = Payment.find(params[:id])
    @payment.update_attributes(status: "Pending")
    redirect_to dashboard_path
  end

  def set_accepted
    @payment = Payment.find(params[:id])
    @payment.update_attributes(status: "Accepted")
    redirect_to dashboard_path
  end

  def set_rejected
    @payment = Payment.find(params[:id])
    @payment.update_attributes(status: "Rejected")
    redirect_to dashboard_path
  end

  private

    def set_user
      @user = current_user
    end

    def payment_params
      params.require(:payment).permit(:order_id, :payment_method, :payment_date, :payment_time, :reference_number, :total_payment, :attachment, :receipt_number)
    end
end
