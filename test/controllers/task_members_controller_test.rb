require "test_helper"

class TaskMembersControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get task_members_create_url
    assert_response :success
  end
end
