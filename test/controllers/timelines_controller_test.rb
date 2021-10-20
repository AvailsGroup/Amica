require "test_helper"

class TimelinesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get timelines_index_url
    assert_response :success
  end
end
