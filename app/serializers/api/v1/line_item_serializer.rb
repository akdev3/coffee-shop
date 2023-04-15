class Api::V1::LineItemSerializer < ActiveModel::Serializer
  attributes :id, :quantity, :price, :disc

  belongs_to :order, serializer: Api::V1::OrderSerializer
  belongs_to :item, serializer: Api::V1::ItemSerializer
end
