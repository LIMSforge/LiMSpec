require 'integration_test_helper'

class OrganizationManagementTest < ActionDispatch::IntegrationTest
  test 'Users must request to be added to existing organization' do
    create(:organization, orgName: "My Test Organization")
    login_basic_user
    visit edit_user_path(@user)
    select 'My Test Organization', from: 'organization_select'
    click_button('Submit')
    assert(@user.organization_id.nil?)

  end

  test 'Selecting an organization will create an organization membership request' do
    @organization = create(:organization, orgName: "My Test Organization")
    authenticate_basic_user
    visit edit_user_path(@user)
    select 'My Test Organization', from: 'organization_select'
    click_button('Submit')

    @requestRecord = MembershipRequest.where(user_id: @user.id, organization_id: @organization.id)

  end

  test 'Users can create new organizations' do
     authenticate_basic_user
     visit edit_user_path(@user)
     click_link('Create Organization')
     assert_difference('Organization.count') do
        fill_in('Vendor Name', with: 'My test organization')
        click_button('Create Organization')
     end

  end

  test 'Organization admins can invite users to join their organization' do
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

  test 'Invited users are able to join an organization without requiring approval' do
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

  test 'Before an organization is created a list of similar organizations is presented as suggestions' do
    flunk("not yet implemented")
  end

  test 'Organizations that are vendors can create a product list' do
    flunk("not yet implemented")
  end

  test 'Organizations that are not vendor cannot create a product list' do
    flunk("not yet implemented")
  end

  test 'Vendor organizations require approval by administrators before creation' do
    flunk("not yet implemented")
  end

  test 'Users defined as organization administrators have access to associate vendors to their organization' do
    flunk("not yet implemented")
  end

end
