require 'integration_test_helper'

describe "Product question integration" do
  it "Should show assigned questions when assigned question link is clicked" do
    authenticate_admin_user
    @product = create(:product)

    3.times do
      @question = create(:question)
      create(:product_question, product_id: @product.id, question_id: @question.id)
    end
    visit product_path(@product)
    click_on("Assigned Questions")
    page.has_css?("div.questions li", count: 3)

  end
  it "Should have a link to add assigned questions on the assigned questions page" do
    authenticate_admin_user
    @product = create(:product)
    visit product_path(@product)
    click_on("Assigned Questions")
    page.has_text?("Add Questions")
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
    visit product_path(@product)
    3.times do
      @question = create(:question)
    end
    click_on("Assigned Questions")
    click_on("Add Questions")
    check("Question_ids[]")
    click_on("Select Questions")
    assert_equal(ProductQuestion.count, 1)
  end

  it "Should allow user to filter unassigned questions based on industry" do
    authenticate_admin_user
    @product = create(:product)
    visit product_path(@product)
    @industry = create(:industry)
    @question = create(:question)
    @indQuestion = create(:ind_question)
    @indQuestion.question_id = @question.id
    @indQuestion.industry_id = @industry.id
    @indQuestion.save!

    3.times do
      @question = create(:question)
    end
    click_on("Assigned Questions")
    click_on("Add Questions")


  end


end