class CreateQuestionVersions < ActiveRecord::Migration
  def change
    create_table :question_versions do |t|
      t.integer :quest_id
      t.string :qTitle
      t.text :qText
      t.string :status
      t.integer :version

      t.timestamps
    end
  end
end
