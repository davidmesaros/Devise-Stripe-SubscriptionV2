class AddWebsiteIdToAdvertises < ActiveRecord::Migration
  def change
    add_reference :advertises, :website, index: true, foreign_key: true
  end
end
