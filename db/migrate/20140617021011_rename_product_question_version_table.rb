class RenameProductQuestionVersionTable < ActiveRecord::Migration
  def up
    rename_table :product_question_version, :product_question_versions
  end

  def down
    rename_table :product_question_versions, :product_question_version
  end
end
