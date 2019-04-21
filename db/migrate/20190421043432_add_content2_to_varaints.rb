class AddContent2ToVaraints < ActiveRecord::Migration[5.2]
  def change
    add_column :variants, :content2, :string
  end
end
