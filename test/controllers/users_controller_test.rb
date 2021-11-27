require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get profile" do
    get users_profile_url
  end
  test "should get controller" do
    get users_controller_url
    assert_response :success
  end
end
