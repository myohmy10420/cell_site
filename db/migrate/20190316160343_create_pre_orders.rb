class CreatePreOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :pre_orders do |t|
      t.integer :user_id
      t.integer :product_id
      t.string :product_name
      t.integer :selling_price
      t.text :content
      t.text :note

      t.timestamps
    end
  end
end
