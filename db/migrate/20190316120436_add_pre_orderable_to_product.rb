class AddPreOrderableToProduct < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :pre_orderable, :bool
  end
end
