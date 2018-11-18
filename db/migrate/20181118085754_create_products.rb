class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string  :name
      t.string  :slogan
      t.text    :content
      t.integer :list_price
      t.integer :selling_price
      t.boolean :shelved,      default: false
      t.boolean :priced,       default: false
      t.string  :avatar

      t.timestamps
    end
  end
end
