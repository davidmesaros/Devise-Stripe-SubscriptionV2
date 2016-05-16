class CreateDataDashboards < ActiveRecord::Migration
  def change
    create_table :data_dashboards do |t|
      t.integer :calls
      t.integer :clicks
      t.integer :searches
      t.integer :cost
      t.integer :budget
      t.integer :smartphones
      t.integer :tablets
      t.integer :computers
      t.references :dashboard, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
