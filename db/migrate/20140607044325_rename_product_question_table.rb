class RenameProductQuestionTable < ActiveRecord::Migration
  def up
    rename_table :product_question, :product_question_version
  end

  def down
    rename_table :product_question_version, :product_question
  end
end
