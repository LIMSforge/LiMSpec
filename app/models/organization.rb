class Organization < ActiveRecord::Base
  attr_accessible :orgName, :orgType
  has_many :responses
  has_many :users
  has_many :clients, through: :vendor_clients, foreign_key: 'vendor_id'
  has_many :vendors, through: :vendor_clients, foreign_key: 'client_id'
  has_many :projects, through: :project_organizations
end
