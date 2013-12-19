class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.integer :organization_id
      t.integer :organization_id
      t.integer :requirement_id
      t.integer :question_id

      t.timestamps
    end
  end
end
