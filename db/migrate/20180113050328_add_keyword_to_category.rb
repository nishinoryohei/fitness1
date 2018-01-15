class AddKeywordToCategory < ActiveRecord::Migration[5.1]
  def change
    add_column :categories, :keyword, :string
  end
end
