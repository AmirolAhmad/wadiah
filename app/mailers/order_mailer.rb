class OrderMailer < ApplicationMailer
  default from: '"Wadiah Savings" <no-reply@wadiahsaving.com>'

  def order_email(order)
    @order = order

    mail(
      :to => "#{order.user.username} <#{order.user.email}>",
      :subject => "New Order #{order.order_number} has been place!"
      )
   end

   def notify_admin(order)
    @order = order

    mail(
      :to => "wadiahsavings@gmail.com",
      :subject => "New order has been created by #{order.user.username}!"
    )
   end
end
