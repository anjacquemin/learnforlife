require "test_helper"

class ThemesControllerTest < ActionDispatch::IntegrationTest
  test "should get themes index" do
    get root_url
    assert_response :success
    # assert_redirected_to login_url
  end

  test "should get themes show" do
    get root_url
    assert_response :success
    # assert_redirected_to login_url
  end
end
