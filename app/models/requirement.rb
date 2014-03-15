class Requirement < ActiveRecord::Base

  has_many :ind_requirements  #, dependent: :destroy
  has_many :requirement_versions
  has_many :industries, through: :ind_requirements
  has_many :responses
  belongs_to :category
  scope :active, where(:active => true)
  default_scope active.includes(:category).order('categories.catName')
  scope :submitted, where(:status => :Submitted)
  scope :public, where(:status => :Public)

  accepts_nested_attributes_for :requirement_versions

  attr_accessible :reqText, :reqTitle, :industry_ids, :category_id, :catName, :status, :user_id, :source_id, :catAbbr, :reqNumber, :sortOrder, :requirement_versions_attributes

  before_save do

    if self.new_record?
      if self.version.nil?
        self.version=1
        self.active = true
      end

    else
     if (self.reqTitle_changed?) | (self.reqText_changed?) | (self.category_id_changed?)
      if self.version >= self.version_was
       @newReq = RequirementVersion.new
       @newReq.req_id = self.id
       @newReq.reqTitle = self.reqTitle_was
       @newReq.reqText = self.reqText_was
       @newReq.category_id = self.category_id_was
       @newReq.status = self.status
       @newReq.version = self.version
       @newReq.save!
       self.version = self.version + 1

       #create list of industries associated with this version
       #TODO determine if the following will work for capturing changes to the industry list, or will it only reflect the new list?

       self.industries.each do |industry|

         @indListMember = ReqVersionIndustries.new
         @indListMember.req_id = self.id
         @indListMember.industry_id = industry.id
         @indListMember.version = @newReq.version
         @indListMember.save!

       end
      end
     end

    end

  end
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
    UserRequirement.where(user_id: user_id, requirement_id: self.id)
  end

  def copied_by_me?(user_id)
    UserRequirement.where(user_id: user_id, requirement_id: self.id).length > 0
  end

  def truncReqText
    n = 10
    if self.reqText.split.size > n
      self.reqText.split[0...n].join(' ') << '...'
    else
      self.reqText
    end
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
