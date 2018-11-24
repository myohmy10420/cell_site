class CreateTelecommunications < ActiveRecord::Migration[5.2]
  def change
    create_table :telecommunications do |t|
      t.string :name
      t.string :logo_file_name
      t.string :logo_content_type
      t.integer :logo_file_size
      t.datetime :logo_updated_at

      t.timestamps
    end
  end
end
