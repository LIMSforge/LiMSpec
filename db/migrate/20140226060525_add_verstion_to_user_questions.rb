class AddVerstionToUserQuestions < ActiveRecord::Migration
  def change
    add_column :user_questions, :version, :integer
  end
end
