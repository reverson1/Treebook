require 'test_helper'

class leafsControllerTest < ActionController::TestCase
  setup do
    @leaf = leafs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:leafs)
  end

  test "should be redirected when not logged in" do
    get :new
    assert_response :redirect
    assert_redirected_to new_user_session_path
  end

  test "should render the new page when logged in" do
    sign_in users(:richard)
    get :new
    assert_response :success
  end

  test "should be logged in to post a leaf" do
    post :create, leaf: {content: "Hello"}
    assert_response :redirect
    assert_redirected_to new_user_session_path
  end 

  test "should create leaf when logged in" do
    sign_in users(:richard)
    assert_difference('leaf.count') do
      post :create, leaf: { content: @leaf.content }
    end

    assert_redirected_to leaf_path(assigns(:leaf))
  end

  test "should show leaf" do
    get :show, id: @leaf
    assert_response :success
  end

  test "should get edit when logged in" do
    sign_in users(:richard)
    get :edit, id: @leaf
    assert_response :success
  end

  test "should update leaf when logged in" do
    sign_in users(:richard)
    patch :update, id: @leaf, leaf: { content: @leaf.content }
    assert_redirected_to leaf_path(assigns(:leaf))
  end

  test "should destroy leaf" do
    assert_difference('leaf.count', -1) do
      delete :destroy, id: @leaf
    end

    assert_redirected_to leafs_path
  end
end