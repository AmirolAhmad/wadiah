class PaymentMailer < ActionMailer::Base
  default from: '"Wadiah Savings" <no-reply@wadiahsaving.com>'

  def payment_email(payment)
    @payment = payment

    # pdf = PaymentPdf.new(@payment, view_context)
    # attachments["receipt.pdf"] = { :mime_type => 'application/pdf', :content => pdf.render }

    mail(
      :to => "#{payment.user.username} <#{payment.user.email}>",
      :subject => "New payment #{payment.receipt_number} has been added!"
      )
   end

   def notify_admin(payment)
    @payment = payment

    mail(
      :to => "wadiahsavings@gmail.com",
      :subject => "New payment has been created by #{payment.user.username}!"
    )
   end
end
