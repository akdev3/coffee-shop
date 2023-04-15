class GroupDeal < ApplicationRecord
  belongs_to :item
  belongs_to :group_item
end
