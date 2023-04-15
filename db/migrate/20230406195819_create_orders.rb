class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.references :customer, null: false, foreign_key: true
      t.decimal :total_price, default: 0, null: false
      t.decimal :discounted_price, default: 0, null: false
      t.string :order_number, null: false
      t.integer :status, default: 0, null: false

      t.timestamps
    end
    add_index :orders, :order_number
  end
end
