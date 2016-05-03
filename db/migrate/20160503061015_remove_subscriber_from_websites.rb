class RemoveSubscriberFromWebsites < ActiveRecord::Migration
  def change
    remove_column :websites, :subscriber, :boolean
  end
end
