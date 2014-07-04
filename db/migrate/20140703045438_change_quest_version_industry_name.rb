class ChangeQuestVersionIndustryName < ActiveRecord::Migration
  def up
    rename_table :quest_version_industry, :question_version_industries

  end

  def down
  end
end
