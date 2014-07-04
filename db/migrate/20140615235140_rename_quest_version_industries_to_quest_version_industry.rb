class RenameQuestVersionIndustriesToQuestVersionIndustry < ActiveRecord::Migration
  def up
    rename_table :quest_version_industries, :quest_version_industry
  end

  def down
  end
end
