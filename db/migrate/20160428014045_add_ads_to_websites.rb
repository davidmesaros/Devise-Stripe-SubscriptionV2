class AddAdsToWebsites < ActiveRecord::Migration
  def change
    add_column :websites, :advertising, :boolean, default: false
  end
end
