FactoryGirl.define do

  #USERS AND ROLES

  factory :authentication do

  end
  factory :identity do |f|
        f.sequence(:name) {|n| "Foo#{n} Bar"}
        f.sequence(:email) { |n| "foo#{n}@example.com"}
        f.password "fooBar_1"
  end
  factory :user do |f|
        f.sequence(:name) { |n| "foo#{n}" }
        #password "fooBar_1"
        f.sequence (:email) {|n| "foo#{n}@example.com" }
        provider "identity"
        app_setting
     after(:create) do |user, evaluator|
        FactoryGirl.create_list(:ind_user, 1, user: user)
     end

     factory :adminUser do
       after(:create) do |user, evaluator|
         FactoryGirl.create_list(:adminAssignment, 1, user: user)

       end
     end
    factory :reader do |user|
      after(:create) do |user, evaluator|
               FactoryGirl.create_list(:readerAssignment, 1, user: user)
      end
    end
    factory :editor do |user|
          after(:create) do |user, evaluator|
                   FactoryGirl.create_list(:editorAssignment, 1, user: user)
          end
    end

  end

  factory :role_assignment do
     factory :adminAssignment do |ra|
         ra.association :role, factory: :adminRole
     end
     factory :readerAssignment do
       association :role
     end
     factory :editorAssignment do  |ra|
        ra.association :role, factory: :editorRole
      end
  end

  factory :role do
     roleName "reader"
     factory :adminRole do |r|
       r.roleName "Administrator"
     end
    factory :editorRole do |r|
      r.roleName "Editor"
    end
  end

  factory :app_setting do
    showIndustry true
  end

  factory :ind_user do
    industry {Industry.first || FactoryGirl.create(:industry)}
  end

  factory :industry do
    sequence(:indName) {|n| "Test Industry#{n}"}
  end
############

#Requirements, User Requirements, and Related

factory :user_requirement do

  factory :ur_with_user do
    user
  end
  factory :nonModified do
    userModified false
  end
  factory :userModified do
    req_title "Test User Requirement"
    req_text  "This is a test user requirement for the purposed of, um, testing things"
    userModified true

  end
end

factory :requirement do
  sequence(:reqTitle) {|t| "Test Requirement #{t}"}
  ignore do
    categoryName " "
    categoryAbbr " "
  end

  reqText "This is a test general requirement for the purpose of, um, testing things"
  status "Public"
  factory :reqWithCat do
    category
  end
  factory :reqWithNamedCat do
    category {create(:category, catName: categoryName, catAbbr: categoryAbbr)}
  end
  factory :reqWithIndustry do
    after(:create) do |requirement, evaluator|
        FactoryGirl.create_list(:ind_requirement, 1, requirement: requirement)
      end
  end
  factory :reqFromUserRequirement do
    user_requirement
  end
end
factory :ind_question do

end
factory :ind_requirement do
  industry {Industry.first || FactoryGirl.create(:industry)}
end

factory :ind_user_requirement do
  user_requirement
  industry
end

factory :category do
    catName "The category name"
    catAbbr "CN"
end
########

#Questions, user questions, and related

factory :question do
  qTitle "Random question for testing"
  qText "This is really just a random jumble of general silliness"
end

factory :user_question do
  factory :uq_with_user do
      user
  end
  qTitle "Random user question for testing"
  qText "Another testing thing"

end

factory :ind_user_question do
  user_question
  industry
end

factory :response do

end

factory :organization do

end

factory :projects_users do

end

factory :project do



end

factory :product do

end
end
