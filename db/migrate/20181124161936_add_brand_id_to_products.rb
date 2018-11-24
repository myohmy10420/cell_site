class AddBrandIdToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :brand_id, :integer
  end
end
