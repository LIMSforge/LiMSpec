require 'integration_test_helper'

describe "Product question integration" do
  it "Should show assigned questions when assigned question link is clicked" do
    authenticate_admin_user

    3.times do
      create(:question)
    end

    @product = create(:product, question_versions: QuestionVersion.all)

    visit product_path(@product)
    click_on("Assigned Questions")
    page.has_css?("div.questions li", count: 3)

  end

  it "Should have a link to add assigned questions on the assigned questions page" do
    authenticate_admin_user
    @product = create(:product)
    visit product_path(@product)
    click_on("Assigned Questions")
    page.has_link?("Add Questions")
  end

  it "Should present a window with unassociated questions when the assign questions link is clicked" do
    authenticate_admin_user
    @product = create(:product)
    visit product_path(@product)
    3.times do
      @question = create(:question)
    end
    click_on("Assigned Questions")
    click_on("Add Questions")
    page.has_css?("div.questions li", count: 3)
  end
  it "Should associate question to product when question is selected" do
    authenticate_admin_user
    @product = create(:product)
    3.times do
      @question = create(:question)
    end
    visit product_path(@product)
    click_on("Add Questions")
    check("question_ids[]")
    click_on("Assign Questions to Product")
    assert_equal(@product.question_versions.count, 1)
  end

  it "Should allow user to filter unassigned questions based on industry" do
    authenticate_admin_user
    @product = create(:product)
    @industry = create(:industry)
    @question = create(:question)
    @indQuestion = create(:ind_question)
    @indQuestion.question_id = @question.id
    @indQuestion.industry_id = @industry.id
    @indQuestion.save!

    3.times do
      @question = create(:question)
    end
    visit product_path(@product)
    click_on("Assigned Questions")
    click_on("Add Questions")
    save_and_open_page
    select @industry.indName, from: "industry_id"
    click_on("Filter Questions by Industry")
    page.has_css?("div.questions li", count: 3)


  end


end