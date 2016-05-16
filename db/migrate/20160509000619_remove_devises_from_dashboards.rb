class RemoveDevisesFromDashboards < ActiveRecord::Migration
  def change
    remove_column :dashboards, :devise, :string
  end
end
