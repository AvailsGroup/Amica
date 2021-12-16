require "test_helper"

class MailerControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get new_mailer_url
    assert_response :success
  end

  test "should get create" do
    get mailer_create_url
    assert_response :success
  end
end
