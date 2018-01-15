class CreateCartItems < ActiveRecord::Migration[5.1]
  def change
    create_table :cart_items do |t|
      t.integer :item_id
      t.integer :user_id
      t.integer :quantity,default: 0
      t.boolean :is_purchase, default: true

      t.timestamps
    end
  end
end
