class CreateJoinTableGroupDeals < ActiveRecord::Migration[6.1]
  def change
    create_table :group_deals, id: false do |t|
      t.belongs_to :item
      t.belongs_to :group_item
    end

    add_index :group_deals, [:item_id, :group_item_id], unique: true
  end
end
