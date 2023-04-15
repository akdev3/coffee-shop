class CreatePromotionLineItems < ActiveRecord::Migration[6.1]
  def change
    create_table :promotion_line_items do |t|
      t.references :source_item, null: false
      t.references :dest_item, null: false

      t.timestamps
    end
    add_foreign_key :promotion_line_items, :items, column: :source_item_id
    add_foreign_key :promotion_line_items, :items, column: :dest_item_id
  end
end
