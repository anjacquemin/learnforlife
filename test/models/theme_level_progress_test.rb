require "test_helper"

class ThemeLevelProgressTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    #  @theme_level_progress1 = ThemeLevelProgress.new(user: users(:anthony), theme_level: theme_levels(:level_1), unlocked: false)
    @theme_level_progress_1 = theme_level_progresses(:theme_level_progress_1)
  end

  test "theme level progress should be valid" do
    assert @theme_level_progress_1.valid?, "errors: #{@theme_level_progress_1.errors.messages}"
  end

  test "theme level progress should have a user" do
    @theme_level_progress_1.user = nil
    assert_not @theme_level_progress_1.valid?
  end

  test "theme level progress should have a theme level" do
    @theme_level_progress_1.theme_level = nil
    assert_not @theme_level_progress_1.valid?
  end
end
