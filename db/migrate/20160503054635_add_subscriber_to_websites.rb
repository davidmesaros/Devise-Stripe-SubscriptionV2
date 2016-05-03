class AddSubscriberToWebsites < ActiveRecord::Migration
  def change
    add_column :websites, :subscriber, :boolean, default: false
  end
end
