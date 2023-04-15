class LineItem < ApplicationRecord
  belongs_to :order

  belongs_to :item, optional: true
  belongs_to :group_item, optional: true
  belongs_to :promotion_line_item, optional: true

  enum category: { item: 0, group_item: 1, promotion_line_item: 2 }

  validates :quantity, presence: true
  # validates :price, presence: true,
  validates :disc, presence: true

  after_commit :calculate_prices

  def self.calculate_item_prices(line_item)
    item_price = 0
    item_discount = 0
    line_item_disc = 0

    if line_item[:item_id]
      item_id, quantity, line_item_disc = line_item.values_at(:item_id, :quantity, :disc)

      item = Item.find(item_id)
      item_price = item.price * quantity
      item_discount = line_item_disc * quantity
    elsif line_item[:group_item_id]
      group_item_id, quantity = line_item.values_at(:group_item_id, :quantity)

      item = GroupItem.find(group_item_id)
      item_price = item.items.sum(:price) * quantity
      item_discount = item.disc_amount * quantity
      line_item_disc = item.disc_amount
    elsif line_item[:promotion_line_item_id]
      promotion_line_item_id, quantity = line_item.values_at(:promotion_line_item_id, :quantity)

      item = PromotionLineItem.find(promotion_line_item_id).source_item
      item_price = item.price * quantity
      item_discount = line_item_disc * quantity
    end

    return item_price, item_discount, line_item_disc
  end

  private
    def calculate_prices
      order = self.order
      total_price = 0
      discount = 0
    
      order.line_items.each do |line_item|
        item_price, item_discount = LineItem.calculate_item_prices(line_item)
        total_price += item_price
        discount += item_discount
      end

      if Order.find_by(id: order.id)
        order.total_price = total_price
        order.discounted_price = total_price - discount
        order.save
      end
    end
end
