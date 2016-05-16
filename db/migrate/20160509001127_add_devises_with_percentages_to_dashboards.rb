class AddDevisesWithPercentagesToDashboards < ActiveRecord::Migration
  def change
    add_column :dashboards, :smartphones, :integer
    add_column :dashboards, :tablets, :integer
    add_column :dashboards, :computers, :integer
  end
end
