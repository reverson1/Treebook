require 'test_helper'

class ProfilesControllerTest < ActionController::TestCase
  test "should get show" do
    get :show, id: users(:richard).profile_name
    assert_response :success
    assert_template 'profiles/show'
  end

  test "render a 404 error when profile not found" do
  	get :show, id: "doesn't exist"
    assert_response :not_found 	
  end

  test "that variables are assigned on successful profile viewing" do
	get :show, id: users(:richard).profile_name
	assert assigns(:user)
	assert_not_empty assigns(:statuses)
  end

  test "only shows the correct user's statuses" do
    get :show, id: users(:richard).profile_name
    assigns(:statuses).each do |status|
      assert_equal users(:richard), status.user
    end
  end
end