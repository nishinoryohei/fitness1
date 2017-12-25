class CreateTrainings < ActiveRecord::Migration[5.1]
  def change
    create_table :trainings do |t|
      t.integer :progress, default: 0
      t.integer :goal, default: 0
      t.boolean :fruition ,default: false

      t.timestamps
    end
  end
end
