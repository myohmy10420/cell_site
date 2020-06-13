class AddEnableToVariants < ActiveRecord::Migration[5.2]
  def change
    add_column :variants, :enable, :bool, default: true
  end
end
