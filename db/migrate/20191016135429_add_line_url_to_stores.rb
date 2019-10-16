class AddLineUrlToStores < ActiveRecord::Migration[5.2]
  def change
    add_column :stores, :line_url, :string
  end
end
