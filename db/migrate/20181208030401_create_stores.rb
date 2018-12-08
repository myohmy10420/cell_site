class CreateStores < ActiveRecord::Migration[5.2]
  def change
    create_table :stores do |t|
      t.string :name
      t.string :service_line
      t.string :fax
      t.string :phone
      t.string :email
      t.string :line_ID
      t.string :address
      t.string :time

      t.timestamps
    end
  end
end
