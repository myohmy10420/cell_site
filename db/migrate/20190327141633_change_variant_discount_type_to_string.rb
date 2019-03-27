class ChangeVariantDiscountTypeToString < ActiveRecord::Migration[5.2]
  def change
    change_column :variants, :discount, :string
  end
end
