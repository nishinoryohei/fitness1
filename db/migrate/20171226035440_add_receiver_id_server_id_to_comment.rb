class AddReceiverIdServerIdToComment < ActiveRecord::Migration[5.1]
  def change
    add_column :comments, :receiver_id, :integer
    add_column :comments, :server_id, :integer
  end
end
