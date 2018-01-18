class CreatePersonals < ActiveRecord::Migration[5.1]
  def change
    create_table :personals do |t|
      t.string :tel
      t.integer :state
      t.string :city
      t.string :address
      t.string :user_id

      t.timestamps
    end
  end
end
