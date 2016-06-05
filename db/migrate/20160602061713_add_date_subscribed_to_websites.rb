class AddDateSubscribedToWebsites < ActiveRecord::Migration
  def change
    add_column :websites, :date_subscribed, :date
  end
end
