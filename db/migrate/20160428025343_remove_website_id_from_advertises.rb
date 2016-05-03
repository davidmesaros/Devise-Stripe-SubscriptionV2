class RemoveWebsiteIdFromAdvertises < ActiveRecord::Migration
  def change
    remove_reference :advertises, :website_id, index: true, foreign_key: true
  end
end
