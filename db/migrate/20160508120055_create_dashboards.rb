class CreateDashboards < ActiveRecord::Migration
  def change
    create_table :dashboards do |t|
      t.integer :calls
      t.integer :clicks
      t.integer :searches
      t.integer :cost
      t.integer :budget
      t.string :devise
      t.references :website, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
