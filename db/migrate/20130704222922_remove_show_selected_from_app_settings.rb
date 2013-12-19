class RemoveShowSelectedFromAppSettings < ActiveRecord::Migration
  def up
    remove_column :app_settings, :showSelected
  end

end
