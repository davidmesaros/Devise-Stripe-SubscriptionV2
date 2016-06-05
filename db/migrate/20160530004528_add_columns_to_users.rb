class AddColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :end_date, :date
    add_column :users, :delinquent, :boolean
  end
end
