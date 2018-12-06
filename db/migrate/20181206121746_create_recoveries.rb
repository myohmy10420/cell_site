class CreateRecoveries < ActiveRecord::Migration[5.2]
  def change
    create_table :recoveries do |t|
      t.string  :name
      t.integer :brand_id
      t.integer :max_price
      t.integer :min_price

      t.timestamps
    end
  end
end
