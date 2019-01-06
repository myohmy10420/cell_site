class AddTwoStatusToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :is_new, :bool, default: false
    add_column :products, :is_pop, :bool, default: false
  end
end
