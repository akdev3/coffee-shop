class Item < ApplicationRecord
  has_many :source_promotion_line_items, class_name: 'PromotionLineItem', foreign_key: 'source_item_id', dependent: :destroy
  has_many :dest_promotion_line_items, class_name: 'PromotionLineItem', foreign_key: 'dest_item_id', dependent: :destroy

  has_many :line_items, dependent: :destroy

  has_many :group_deals
  has_many :group_items, through: :group_deals
end
