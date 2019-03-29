class AddSortToBrands < ActiveRecord::Migration[5.2]
  def change
    add_column :brands, :sort, :integer
  end
end
