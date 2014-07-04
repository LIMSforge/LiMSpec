class RenameQuestVersionId < ActiveRecord::Migration
  def up
    rename_column :products_question_versions, :quest_version_id, :question_version_id
  end

  def down
    rename_column :products_question_versions, :question_version_id, :quest_version_id
  end
end
