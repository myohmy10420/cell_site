class AddPaperclipColumsToStore < ActiveRecord::Migration[5.2]
  def change
    add_column :stores, :image_file_name, :string
    add_column :stores, :image_content_type, :string
    add_column :stores, :image_file_size, :integer
    add_column :stores, :image_updated_at, :datetime
  end
end
