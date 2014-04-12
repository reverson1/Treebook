require 'test_helper'

class CustomRoutesTest < ActionDispatch::IntegrationTest
	 test "that /login route opens the login page" do
	 	get '/login'
	 	assert_response :success
	 end

	test "that /logout route opens the logout page" do
	 	get '/logout'
	 	assert_response :redirect
	 	assert_redirected_to '/'
	 end

	 test "that /register route opens the sign up page" do
	 	get '/register'
	 	assert_response :success
	 end	 

	 test "that /feed route opens the status list" do
	 	get '/feed'
	 	assert_response :redirect
	 	assert_redirected_to '/users/sign_in'
	 end	
end
