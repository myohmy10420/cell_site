class AddStoreIdToPreOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :pre_orders, :store_id, :integer
  end
end
