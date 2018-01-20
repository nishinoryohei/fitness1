class AddPaymentStatusToOrder < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :payment_status, :boolean, default: false
  end
end
