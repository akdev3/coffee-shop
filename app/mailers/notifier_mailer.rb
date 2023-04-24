class NotifierMailer < ApplicationMailer
  def new_message_email
    @customer = params[:customer]
    @order = params[:order]
    send_email_notification = params[:send_email_notification]
    if send_email_notification
      mail(to: @customer.email, subject: 'Your order is ready now!')
    end
  end
end
