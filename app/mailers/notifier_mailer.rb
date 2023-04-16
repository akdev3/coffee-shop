class NotifierMailer < ApplicationMailer
  def new_message_email
    @customer = params[:customer]
    @order = params[:order]
    isSendMessage = params[:isSendMessage]
    if isSendMessage
      mail(to: @customer.email, subject: 'Your order is ready now!')
      @order.update(status: :completed)
    end
  end
end
