class AddUserQuestionRelationField < ActiveRecord::Migration
  def up
    add_column :user_questions, :relation, :string
  end

  def down
  end
end
