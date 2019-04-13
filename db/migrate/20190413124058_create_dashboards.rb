class CreateDashboards < ActiveRecord::Migration[5.2]
  def change
    create_table :dashboards do |t|
      t.integer :visitor_count, default: 0

      t.timestamps
    end
  end
end
