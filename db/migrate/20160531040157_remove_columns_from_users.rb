class RemoveColumnsFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :subscribed, :string
    remove_column :users, :boolean, :string
    remove_column :users, :stripeid, :string
    remove_column :users, :end_date, :date
    remove_column :users, :delinquent, :boolean
    remove_column :users, :days_left, :integer
  end
end
