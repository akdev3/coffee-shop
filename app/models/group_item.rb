class GroupItem < ApplicationRecord
  has_many :group_deals
  has_many :items, through: :group_deals
  has_many :line_items, dependent: :destroy

  validates :name, presence: true
  validates :disc_amount, presence: true
end
