class AddSellingTimeToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :selling_time, :datetime

    Product.all.update_all("selling_time = created_at")
  end
end
