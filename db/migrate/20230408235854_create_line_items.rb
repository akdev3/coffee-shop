class CreateLineItems < ActiveRecord::Migration[6.1]
  def change
    create_table :line_items do |t|
      t.references :item, foreign_key: true, optional: true
      t.references :group_item, foreign_key: true, optional: true
      t.references :promotion_line_item, foreign_key: true, optional: true

      t.references :order, null: false, foreign_key: true
      t.integer :quantity, default: 1, null: false
      t.decimal :price, default: 0, null: false
      t.decimal :disc, default: 0, null: false

      t.timestamps
    end
  end
end