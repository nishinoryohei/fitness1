class CreateBodies < ActiveRecord::Migration[5.1]
  def change
    create_table :bodies do |t|
      t.decimal :weight, precision: 3, scale: 1
      t.decimal :height, precision: 3, scale: 1
      t.decimal :bmi, precision: 3, scale: 1
      t.integer :score

      t.timestamps
    end
  end
end
