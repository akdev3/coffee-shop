class CreateCustomers < ActiveRecord::Migration[6.1]
  def change
    create_table :customers do |t|
      t.string :name, default: '', null: false
      t.string :email, limit: 50, null: false

      t.timestamps
    end
  end
end
