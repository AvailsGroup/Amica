require "test_helper"

class ProfilesControllerTest < ActionDispatch::IntegrationTest
  test "should get question" do
    get profiles_show_url
    assert_response :success
  end
end
