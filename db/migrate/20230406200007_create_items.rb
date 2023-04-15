class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.string :name, default: '', null: false
      t.decimal :price, default: 0, null: false

      t.timestamps
    end
  end
end
