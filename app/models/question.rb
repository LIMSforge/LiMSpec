class Question < ActiveRecord::Base

  has_many :ind_questions, dependent: :destroy
  has_many :industries, through: :ind_questions
  has_many :user_questions, dependent: :destroy
  has_many :users, through: :user_questions
  has_many :responses
  scope :active, where(:active => true)
  scope :submitted, where(:status => :Submitted)
  scope :public, where(:status => :Public)
  scope :private, where(:status => :Private)
  default_scope active

  accepts_nested_attributes_for :user_questions

  attr_accessible :qText, :qTitle, :status, :industry_ids, :user_id, :source_id, :questNumber

  before_save do
    if self.new_record?
          if self.version.nil?
            self.version=1
            self.active = true
          end

        else
         if (self.qTitle_changed?) | (self.qText_changed?)
          if self.version >= self.version_was


           @newQuest = QuestionVersion.new
           @newQuest.quest_id = self.id
           @newQuest.qTitle = self.qTitle_was
           @newQuest.qText = self.qText_was
           @newQuest.status = self.status
           @newQuest.version = self.version
           @newQuest.save!
           self.version = self.version + 1

           #TODO determine if the following will work for capturing changes to the industry list, or will it only reflect the new list?

                  self.industries.each do |industry|
                    @indListMember = QuestVersionIndustries.new
                    @indListMember.quest_id = self.id
                    @indListMember.industry_id = industry.id
                    @indListMember.version = @newQuest.version
                    @indListMember.save!
                  end
           end
         end
        end

  end

  searchable do
     text :qText, :qTitle
  end

  def industryList
      self.industries.map {|industry| industry.indName}.join(", ")
  end

  def questNumber
    "Q-" + self.id.to_s
  end

  def self.industry_questions(industryArray)
        joins(:industries).where(:industries => {:indName => industryArray} )
  end

  def copied_by_me?(user_id)
        UserQuestion.where(user_id: user_id, question_id: self.id).length > 0
  end

  def self.clone(targetQuestion)
      newQ = Question.new

      newQ.source_id = targetQuestion.id
      newQ.status = "Private"
      newQ.save
      return newQ
  end

  def alterSelected(select)



  end
  def to_xml options={}

      super(options) do |xml|

        xml.questNumber self.questNumber
        xml.industries do
          industries.each do |industry|
            xml.industry industry.indName
          end
        end

      end

    end

end
