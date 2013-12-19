class AddTitleAndTextToUserRequirements < ActiveRecord::Migration
  def change
    add_column :user_requirements, :req_title, :string
    add_column :user_requirements, :req_text, :text
  end
end
