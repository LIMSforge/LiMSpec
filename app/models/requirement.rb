class Requirement < ActiveRecord::Base

  has_many :ind_requirements, dependent: :destroy
  has_many :industries, through: :ind_requirements
  has_many :user_requirements, dependent: :destroy
  has_many :responses
  belongs_to :category
  default_scope includes(:category).order('categories.catName')
  scope :submitted, where(:status => :Submitted)
  scope :public, where(:status => :Public)
  has_many :users, through: :user_requirements

  accepts_nested_attributes_for :user_requirements

  attr_accessible :reqText, :reqTitle, :industry_ids, :category_id, :catName, :status, :user_id, :source_id, :catAbbr, :reqNumber, :sortOrder


  searchable do
    text :reqText, :reqTitle
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

  def self.catFilter(catSearch)
    if catSearch && catSearch!=""
      where('categories.catName = ?', catSearch)
    else
      scoped
    end
  end

  def self.only_ind_reqs(indArray)
    joins(:industries).where(:industries => {:indName => indArray} )
  end

  def self.copied_by_me(user_id)
    joins(:user_requirements).where("user_id = ?", user_id)
  end

  def copied_by_me?(user_id)
    self.user_requirements.where("user_id = ?", user_id).length > 0
  end

  def self.my_requirements(user_id)
      joins(:user_requirements).where("user_id = ?", user_id)
  end

  def catName
    if self.category.nil?
      "Not Defined"
    else
      self.category.catName
    end
  end

  #def self.clone(targetRequirement)
     #newReq = Requirement.new

    #newReq.category_id = targetRequirement.category_id
    #newReq.source_id = targetRequirement.id
    #newReq.status = "Private"
    #newReq.save
    #return newReq
  #end


  def to_xml options={}

    super(options) do |xml|

      xml.reqNumber self.reqNumber

      if ! self.category.nil?
        xml.category self.category.catName
      else
        xml.category "Not defined"
      end


      xml.industries do
        industries.each do |industry|
          xml.industry industry.indName
        end
      end

    end

  end



end
