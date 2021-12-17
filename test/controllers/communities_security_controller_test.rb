require "test_helper"

class CommunitiesSecurityControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get communities_security_create_url
    assert_response :success
  end

  test "should get destroy" do
    get communities_security_destroy_url
    assert_response :success
  end
end
