class AddGoogleMapUrlToStore < ActiveRecord::Migration[5.2]
  def change
    add_column :stores, :google_map_url, :string
  end
end
