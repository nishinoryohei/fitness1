class AddNameStatusToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :name, :string
    add_column :users, :status, :integer
  end
end
