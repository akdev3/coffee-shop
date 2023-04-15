class Api::V1::PromotionLineItemSerializer < ActiveModel::Serializer
  attributes :id

  belongs_to :source_item, serializer: Api::V1::ItemSerializer
  belongs_to :dest_item, serializer: Api::V1::ItemSerializer
end
