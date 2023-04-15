class Api::V1::OrderSerializer < ActiveModel::Serializer
  attributes :id, :total_price, :discounted_price, :order_number, :status

  has_many :line_items, serializer: Api::V1::LineItemSerializer
  belongs_to :customer, serializer: Api::V1::CustomerSerializer
end
