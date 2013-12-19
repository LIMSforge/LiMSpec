class CreateAppSettings < ActiveRecord::Migration
  def change
    create_table :app_settings do |t|
      t.integer :user_id
      t.boolean :showIndustry
      t.boolean :showSelected

      t.timestamps
    end
  end
end
