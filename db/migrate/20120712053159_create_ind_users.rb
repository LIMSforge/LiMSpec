class CreateIndUsers < ActiveRecord::Migration
  def change
    create_table :ind_users do |t|
      t.integer :user_id
      t.integer :industry_id
      t.timestamps
    end
  end
end
