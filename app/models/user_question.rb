class UserQuestion < ActiveRecord::Base

  attr_accessible :position, :qText, :qTitle, :userModified, :user_id, :question_id, :industry_ids
  belongs_to :user
  belongs_to :question
  has_many :ind_user_questions, dependent: :destroy
  has_many :industries, through: :ind_user_questions
  has_many :responses
  before_create do
    self.position = self.id
  end

  searchable do
   text :qText, :qTitle
   integer :user_id
   integer :position
  end

  before_save do
   if !self.new_record?
    if (self.qText_changed? || self.qTitle_changed? )  && (!self.question_id.nil?)
        self.userModified = true
    end
   end
    if (self.position.nil?)
          self.position = self.id
    end
   end

  def to_xml options={}

      super(options) do |xml|

        xml.reqNumber self.id

      end

  end

  def industryList
        self.industries.map {|industry| industry.indName}.join(", ")
  end

  def self.createUserQuestion(targetUser, targetQuestion)
    userQuest = UserQuestion.new
    userQuest.question_id = targetQuestion.id
    userQuest.user_id = targetUser.id
    userQuest.qTitle = targetQuestion.qTitle
    userQuest.qText = targetQuestion.qText
    userQuest.save!
    targetQuestion.industries.each do |ind|
      indUQuest = IndUserQuestion.new
      indUQuest.industry_id = ind.id
      indUQuest.user_question_id = userQuest.id
      indUQuest.save!
    end
    userQuest.update_column(:userModified, false)

  end
end
