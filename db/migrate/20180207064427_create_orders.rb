class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.integer :total_fee
      t.boolean :payment_status

      t.timestamps
    end
  end
end
