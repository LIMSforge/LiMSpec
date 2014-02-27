class AddVersionActiveToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :version, :integer
    add_column :questions, :active, :boolean
  end
end
