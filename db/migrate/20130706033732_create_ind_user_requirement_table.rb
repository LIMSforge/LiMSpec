class CreateIndUserRequirementTable < ActiveRecord::Migration
  def up
    create_table :ind_user_requirements do |t|
      t.integer :user_requirement_id
      t.integer :industry_id
      t.timestamps
    end
  end

  def down
    drop_table :ind_user_requirements
  end
end
