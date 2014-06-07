class CreateQuestVersionIndustries < ActiveRecord::Migration
  def change
    create_table :quest_version_industries do |t|
      t.integer :quest_id
      t.integer :industry_id
      t.integer :version

      t.timestamps
    end
  end
end
