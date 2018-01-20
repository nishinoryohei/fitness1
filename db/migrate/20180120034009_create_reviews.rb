class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.integer :item_id
      t.integer :user_id
      t.text :content
      t.integer :score

      t.timestamps
    end
  end
end
