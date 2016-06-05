class RemoveDelinquentFromWebsites < ActiveRecord::Migration
  def change
    remove_column :websites, :delinquent, :boolean
  end
end
