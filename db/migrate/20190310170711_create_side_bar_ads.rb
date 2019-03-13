class CreateSideBarAds < ActiveRecord::Migration[5.2]
  def change
    create_table :side_bar_ads do |t|
      t.string :url
      t.string :image_file_name
      t.string :image_content_type
      t.integer :image_file_size
      t.datetime :image_updated_at
      t.timestamps
    end
  end
end
