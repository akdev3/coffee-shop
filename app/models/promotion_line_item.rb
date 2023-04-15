class PromotionLineItem < ApplicationRecord
  has_many :line_items, dependent: :destroy

  belongs_to :source_item, class_name: 'Item'
  belongs_to :dest_item, class_name: 'Item'
end
