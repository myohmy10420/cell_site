class AddNameUniqToAllModels < ActiveRecord::Migration[5.2]
  def change
    add_index :brands, :name, unique: true
    add_index :products, :name, unique: true
    add_index :recoveries, :name, unique: true
    add_index :stores, :name, unique: true
    add_index :telecommunications, :name, unique: true
    add_index :variants, :name, unique: true
  end
end
