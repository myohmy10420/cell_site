class AddTagToProduct < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :tag, :string
  end
end
