class Api::V1::GroupItemSerializer < ActiveModel::Serializer
  attributes :id, :name, :disc_amount
  has_many :group_deals
  has_many :items, through: :group_deals, serializer: Api::V1::ItemSerializer
end
