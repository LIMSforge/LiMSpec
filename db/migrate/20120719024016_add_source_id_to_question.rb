class AddSourceIdToQuestion < ActiveRecord::Migration
  def change
    add_column :questions, :source_id, :integer
  end
end
