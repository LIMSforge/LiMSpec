class RenameRelationColumnInQuestions < ActiveRecord::Migration
  def up
    rename_column :user_questions, :relation, :relationship
  end

  def down
    rename_column :user_questions, :relationship, :relation
  end
end
