class CreateReqVersionIndustries < ActiveRecord::Migration
  def change
    create_table :req_version_industries do |t|
      t.integer :req_id
      t.integer :version
      t.integer :industry_id

      t.timestamps
    end
  end
end
