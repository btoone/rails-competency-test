class ChangeCategoryTypeToInteger < ActiveRecord::Migration[5.2]
  def change
    remove_column :articles, :category, :string
    add_column :articles, :category, :integer
  end
end
