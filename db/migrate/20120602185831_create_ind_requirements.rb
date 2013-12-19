class CreateIndRequirements < ActiveRecord::Migration
  def change
    create_table :ind_requirements do |t|
      t.integer :industry_id
      t.integer :requirement_id

      t.timestamps
    end
  end
end
