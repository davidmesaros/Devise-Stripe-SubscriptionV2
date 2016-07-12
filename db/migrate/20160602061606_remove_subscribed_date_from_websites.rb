class RemoveSubscribedDateFromWebsites < ActiveRecord::Migration
  def change
    add_column :websites, :subscribed_date, :date
  end
end
