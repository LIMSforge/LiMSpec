class RenameProductQuestionVersionsTable < ActiveRecord::Migration
  def up
    rename_table :product_question_versions, :products_question_versions
  end

  def down
    rename_table :products_question_versions, :product_question_versions
  end
end
