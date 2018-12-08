class AddColumnsToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :phone,    :string
    add_column :users, :line,     :string
    add_column :users, :birthday, :date

    remove_column :users, :email
    add_column    :users, :email, :string
  end
end
