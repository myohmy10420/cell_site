class CreateVariants < ActiveRecord::Migration[5.2]
  def change
    create_table :variants do |t|
      t.string  :name
      t.text    :content
      t.integer :discount
      t.integer :prepaid
      t.string  :traffic
      t.string  :period

      t.timestamps
    end
  end
end
