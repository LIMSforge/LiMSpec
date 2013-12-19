class AddAbbreviationToCategory < ActiveRecord::Migration
  def change
    add_column :categories, :catAbbr, :string
  end
end
