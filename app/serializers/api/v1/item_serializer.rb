class Api::V1::ItemSerializer < ActiveModel::Serializer
  attributes :id, :name, :price

  has_many :group_deals
  has_many :group_items, through: :group_deals, serializer: Api::V1::GroupItemSerializer
end
