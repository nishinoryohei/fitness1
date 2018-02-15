class AddOrderIdToCartitems < ActiveRecord::Migration[5.1]
  def change
    add_column :cart_items, :order_id, :integer,default: 0
  end
end
