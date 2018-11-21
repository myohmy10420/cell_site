class AddTelecommunicationIdToVariant < ActiveRecord::Migration[5.2]
  def change
    add_column :variants, :telecommunication_id, :integer
  end
end
