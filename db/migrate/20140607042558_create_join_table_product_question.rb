class CreateJoinTableProductQuestion < ActiveRecord::Migration
  def up
    create_table :product_question, :id => false do |t|
      t.integer :quest_version_id
      t.integer :product_id
    end
  end

  def down
  end
end
