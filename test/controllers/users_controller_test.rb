require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get controller" do
    get users_controller_url
    assert_response :success
  end
end
