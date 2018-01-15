class CreateCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :categories do |t|
      t.integer :genre
      t.integer :item_id

      t.timestamps
    end
  end
end
