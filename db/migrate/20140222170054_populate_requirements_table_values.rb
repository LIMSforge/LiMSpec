class PopulateRequirementsTableValues < ActiveRecord::Migration

  def change

    Requirement.unscoped.update_all("active = true, version = 1")

  end

end
