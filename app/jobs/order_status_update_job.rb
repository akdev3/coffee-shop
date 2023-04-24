class OrderStatusUpdateJob < ApplicationJob
  queue_as :default

  def perform(order)
    order.update(status: :completed)
    NotifierMailer.with(customer: @customer, send_email_notification: ENV['SEND_NOTIFICATION_EMAIL'], order: @order).new_message_email.deliver_later
  end
end
