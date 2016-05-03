class CreateAdvertises < ActiveRecord::Migration
  def change
    create_table :advertises do |t|
      t.text :description

      t.timestamps null: false
    end
  end
end
