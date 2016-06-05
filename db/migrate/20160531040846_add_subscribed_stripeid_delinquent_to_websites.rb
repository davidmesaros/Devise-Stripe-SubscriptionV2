class AddSubscribedStripeidDelinquentToWebsites < ActiveRecord::Migration
  def change
    add_column :websites, :stripeid, :string
    add_column :websites, :end_date, :date
    add_column :websites, :delinquent, :boolean
    add_column :websites, :days_left, :integer
  end
end
