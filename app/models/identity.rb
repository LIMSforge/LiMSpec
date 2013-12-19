class Identity < OmniAuth::Identity::Models::ActiveRecord

  attr_accessible :name, :email, :uid, :password, :password_confirmation, :user_id
  validates :password, :presence => true,
            :confirmation => true,
            :length => {:within => 6..40},
            :format => {:with => /^.*(?=.{6,})(?=.*[a-z])(?=.*[A-Z])(?=.*[\d\W]).*$/, :message => "needs to have at least one number or symbol, one uppercase, and one lowercase letter"}
  validates_presence_of :name
  validates_uniqueness_of :email
  validates_format_of :email, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i

  def create_from_user(user)

    identity = Identity.new
    identity.name = user.name
    identity.email = user.email
    identity.password = rand(36**10).to_s(36) + "_Lims"
    identity.save!

  end

end

