class Order < ApplicationRecord
  has_many :line_items, dependent: :destroy

  belongs_to :customer

  enum status: { pending: 0, processing: 1, completed: 2, cancelled: 3 }

  validates :total_price, presence: true
  validates :discounted_price, presence: true
  validates :order_number, presence: true, uniqueness: true
  validates :status, presence: true

  before_validation :set_order_number, on: :create
  before_validation :calculate_prices, on: :create

  private

  def calculate_prices
    total_price = 0
    discount = 0

    self.line_items.each do |line_item|
      item_price, item_discount, line_item_disc = LineItem.calculate_item_prices(line_item)

      line_item.price = item_price

      total_price += item_price
      discount += item_discount
    end

    self.total_price = total_price
    self.discounted_price = total_price - discount
  end

  def set_order_number
    last_order = Order.last
    self.order_number = last_order ? last_order.order_number.to_i + 1 : 1
  end
end
