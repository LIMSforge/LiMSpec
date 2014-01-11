class User < ActiveRecord::Base   # OmniAuth::Identity::Models::ActiveRecord

  attr_accessor :no_password
  attr_accessible :no_password, :email, :name, :provider, :uid, :role_ids, :industry_ids, :current, :password_reset_sent_at, :password_reset_token, :firstname, :lastname, :company, :workPhone, :emailSystemNotify, :emailGeneral #, :password, :password_confirmation

  has_many :role_assignments
  has_many :roles, through: :role_assignments
  has_many :authentications
  has_many :user_requirements
  has_many :requirements, through: :user_requirements
  has_many :user_questions
  has_many :questions, through: :user_questions
  has_many :ind_users
  has_many :industries, through: :ind_users
  has_one :app_setting
  belongs_to :organization
  has_many :projects, through: :project_users
  accepts_nested_attributes_for :app_setting, :role_assignments, :ind_users


  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email, :presence   => true,
            :format     => { :with => email_regex },
            :uniqueness => { :case_sensitive => false }

  #validates :password, :presence => true,
              #:confirmation => true,
              #:length => {:within => 6..40},
              #:format => {:with => /^.*(?=.{6,})(?=.*[a-z])(?=.*[A-Z])(?=.*[\d\W]).*$/, :message => "needs to have at least one number or symbol, one uppercase, and one lowercase letter"},
              #:unless => :no_password




  def self.from_omniauth(auth)
    find_by_provider_and_uid(auth["provider"], auth["uid"]) || create_with_omniauth(auth)
  end

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
    #if auth["provider"] != "identity"
      #user.password = rand(36**10).to_s(36) + "_Lims"
    #end
      user.name = auth["info"]["name"]
      user.email = auth["info"]["email"]
    if auth["provider"] == "linkedin"
      user.firstname = auth["info"]["first_name"]
      user.lastname = auth["info"]["last_name"]
      user.company = auth["extra"]["raw_info"]["positions"]["values"].first["company"]["name"]
    end
    end
  end

  def self.admins
    joins(:roles).where(:roles => {:roleName => 'Administrator'})
  end

  def self.generalNoticeRecipients
    where(:emailGeneral => true)
  end

  def role?(role)
    roleName = role.to_s
    return (self.roles.where('roleName = ?', roleName).count > 0)
  end

  def generate_token(column)
      begin
        self[column] = SecureRandom.urlsafe_base64
      end while User.exists?(column => self[column])
  end

  def send_password_reset
    perform_validations = false
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    self.save(:validate => false)

    UserMailer.password_reset(self).deliver
  end



end
