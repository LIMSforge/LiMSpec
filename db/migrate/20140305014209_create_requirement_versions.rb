class CreateRequirementVersions < ActiveRecord::Migration
  def change
    create_table :requirement_versions do |t|
      t.integer :req_id
      t.string :reqTitle
      t.text :reqText
      t.integer :category_id
      t.string :status
      t.integer :version

      t.timestamps
    end
  end
end
