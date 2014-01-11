class CreateProjectUserTable < ActiveRecord::Migration
  def up
    create_table :project_users do |t|
      t.integer :project_id
      t.integer :user_id
      t.string :relationship
    end
  end

  def down
    drop_table :project_users
  end
end
