class CreateIndustriesRequirements < ActiveRecord::Migration
  def change
    create_table :industries_requirements, :id=>'false' do |t|
      t.references :Industry
      t.references :Requirement
      t.timestamps
    end
  end
end
