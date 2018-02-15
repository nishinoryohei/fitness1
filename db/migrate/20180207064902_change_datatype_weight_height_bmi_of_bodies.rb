class ChangeDatatypeWeightHeightBmiOfBodies < ActiveRecord::Migration[5.1]
  def change
  	change_column :bodies, :weight, :float
  	change_column :bodies, :height, :float
  	change_column :bodies, :bmi, :float
  end
end
