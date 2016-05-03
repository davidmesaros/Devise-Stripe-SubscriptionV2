class AddSubscribedToWebsites < ActiveRecord::Migration
  def change
    add_column :websites, :subscribed, :boolean, default: false
  end
end
