class UserRequirement < ActiveRecord::Base

  belongs_to :requirement
  belongs_to :user
  belongs_to :category
  has_many :ind_user_requirements, dependent: :destroy
  has_many :industries, through: :ind_user_requirements
  has_many :responses
  accepts_nested_attributes_for :category
  attr_accessible :requirement_id, :user_id, :req_text, :req_title, :category_id, :catName, :userModified, :position, :industry_ids
  default_scope includes(:category).order('categories.catName')

  searchable do
     text :req_text, :req_title
     integer :user_id
     integer :position
  end

  before_save do
  if !self.new_record?
    if (self.req_text_changed? || self.req_title_changed? || self.category_id_changed?) && (!self.requirement_id.nil?)
      self.userModified = true
    end
  else
    self.userModified = false
  end
    if (self.position.nil?)
      self.position = self.id
    end
  end

  def industryList
      self.industries.map {|industry| industry.indName}.join(", ")
  end

  def reqNumber
      if (self.category.nil? || self.category.catAbbr.nil?)
        "R" + "-" + self.id.to_s
      else
        "R" + self.category.catAbbr + "-" + self.id.to_s
      end
  end

  def self.createUserRequirement (targetUser, targetRequirement)
      userReq = UserRequirement.new
      userReq.user_id = targetUser.id
      userReq.requirement_id = targetRequirement.id
      userReq.category_id = targetRequirement.category_id
      userReq.req_title = targetRequirement.reqTitle
      userReq.req_text = targetRequirement.reqText
      userReq.save!
      targetRequirement.industries.each do |ind|
          indUreq = IndUserRequirement.new
          indUreq.industry_id = ind.id
          indUreq.user_requirement_id = userReq.id
          indUreq.save!
      end
      userReq.update_column(:userModified, false)

  end

  def to_xml options={}

      super(options) do |xml|

        xml.reqNumber self.id
        if !self.category.nil?
          xml.category self.category.catName
        else
          xml.category "Not specified"
        end

        xml.industries do
          industries.each do |industry|
            xml.industry industry.indName
          end
        end

      end

  end
end
