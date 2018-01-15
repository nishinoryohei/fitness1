class CreateThumbnails < ActiveRecord::Migration[5.1]
  def change
    create_table :thumbnails do |t|
      t.string :image
      t.integer :item_id

      t.timestamps
    end
  end
end
