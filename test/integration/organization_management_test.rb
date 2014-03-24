require 'integration_test_helper'

describe "Organization management integration" do
  it 'Allows users to request to be added to existing organization' do
    create(:organization, orgName: "My Test Organization")
    authenticate_basic_user
    visit edit_user_path(@user)
    select 'My Test Organization', from: 'organization_select'
    click_button('Submit')
    assert(@user.organization_id.nil?)

  end

  it 'should create an organization membership request when selecting an organization' do
    @organization = create(:organization, orgName: "My Test Organization")
    authenticate_basic_user
    visit edit_user_path(@user)
    select 'My Test Organization', from: 'organization_select'
    click_button('Submit')

    @requestRecord = MembershipRequest.where(user_id: @user.id, organization_id: @organization.id)

  end

  it 'Should permit users to create new organizations' do
     authenticate_basic_user
     visit edit_user_path(@user)
     click_link('Create Organization')
     assert_difference('Organization.count') do
        fill_in('Vendor Name', with: 'My test organization')
        click_button('Create Organization')
     end

  end

  it 'Should permit organization admins to invite users to join their organization' do
    authenticate_admin_user
    @organization = create(:organization)
    @user.orgAdmin = true
    @user.organization_id = @organization.id
    visit edit_organization_path(@organization)
    fill_in('Invite_Field', with: 'test@example.com')
    click_button('Invite User')
    mail = ActionMailer::Base.deliveries.last
    assert_eq(mail['to'], 'test@example.com')
  end

  it 'Should allow invited users to join an organization without requiring approval' do
    authenticate_admin_user
    @organization = create(:organization)
    @user.orgAdmin = true
    @user.organization_id = @organization.id
    @user.save
    visit edit_organization_path(@organization)
    fill_in('Invite_Field', with: @basicUser.email)
    click_button('Invite User')
    request_token_record = MembershipRequest.find_by_user_id(@basicUser.id)
    request_token = request_token_record.invitation_token
    click_link('Logout')
    authenticate_basic_user
    visit('/membership_requests/accept/#{request_token}')
    click_button('Accept Invitation')
    @invitedUser = User.find_by_email(@basicUser.email)
    assert_eq(@invitedUser.organization_id, @organization.id)
  end

  it 'Should present a list of similar organizations as suggestions before a new organization is created' do
    flunk("not yet implemented")
  end

  it 'Should permit organizations that are vendors to create a product list' do
    flunk("not yet implemented")
  end

  it 'Should not permit organizations that are not vendors to create a product list' do
    flunk("not yet implemented")
  end

  it 'Should require approval by administrators before creation of vendor organizations' do
    flunk("not yet implemented")
  end

  it 'Should permit users defined as organization administrators to associate vendors to their organization' do
    flunk("not yet implemented")
  end

end
