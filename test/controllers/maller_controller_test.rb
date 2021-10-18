require "test_helper"

class MallerControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get maller_new_url
    assert_response :success
  end

  test "should get create" do
    get maller_create_url
    assert_response :success
  end
end
