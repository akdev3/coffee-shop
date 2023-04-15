class CreateGroupItems < ActiveRecord::Migration[6.1]
  def change
    create_table :group_items do |t|
      t.string :name, default: '', null: false
      t.decimal :disc_amount, default: 0, null: false

      t.timestamps
    end
  end
end
