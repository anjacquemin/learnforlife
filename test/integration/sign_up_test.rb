require "test_helper"
require 'minitest/byebug'


class SignupTest < ActionDispatch::IntegrationTest
  test "invalid signup information" do
    get root_url
    # assert_no_difference 'User.count' do
    post user_registration_url, params: { user: { name: "", email: "user@invalid", password: "foo", password_confirmation: "bar" }}, xhr: true
    # end
    # assert_template 'pages/home'
    # assert_select 'div.alert-danger'
  end
end
