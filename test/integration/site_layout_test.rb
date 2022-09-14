require "test_helper"


class SiteLayoutTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:anthony)
    @theme = themes(:geography)
  end

  test "layout links in home page" do
    get root_path
    assert_template 'pages/home'
  end

  test "if not logged in, themes path should redirect to sessions new" do
    get themes_path
    follow_redirect!
    assert_template "devise/sessions/new"
  end

  test "if not logged, geography theme path should redirect to sessions new" do
    get theme_path(@theme)
    follow_redirect!
    assert_template "devise/sessions/new"
  end

  test "if logged in, themes path should redirect to themes index template" do
    sign_in(@user)
    get themes_path
    assert_template "themes/index"
  end

  test "if logged in, geography theme path should redirect to geography template" do
    sign_in(@user)
    get theme_path(@theme)
    assert_template "themes/show"
  end
end
