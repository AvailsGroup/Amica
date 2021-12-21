require "test_helper"

class MuteControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get mute_create_url
    assert_response :success
  end

  test "should get destroy" do
    get mute_destroy_url
    assert_response :success
  end
end
