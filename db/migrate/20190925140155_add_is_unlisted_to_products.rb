class AddIsUnlistedToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :is_unlisted, :bool, default: false
  end
end
