class AddUserIdToBody < ActiveRecord::Migration[5.1]
  def change
    add_column :bodies, :user_id, :string
  end
end
