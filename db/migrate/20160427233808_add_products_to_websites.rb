class AddProductsToWebsites < ActiveRecord::Migration
  def change
    add_column :websites, :product1, :string
    add_column :websites, :product2, :string
  end
end
