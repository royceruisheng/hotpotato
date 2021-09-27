require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get show_friends" do
    get users_show_friends_url
    assert_response :success
  end
end
