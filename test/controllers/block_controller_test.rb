require "test_helper"

class BlockControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get block_create_url
    assert_response :success
  end

  test "should get destroy" do
    get block_destroy_url
    assert_response :success
  end
end
