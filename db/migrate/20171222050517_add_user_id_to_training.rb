class AddUserIdToTraining < ActiveRecord::Migration[5.1]
  def change
    add_column :trainings, :user_id, :integer
  end
end
