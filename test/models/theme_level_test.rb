require "test_helper"

class ThemeLevelTest < ActiveSupport::TestCase

  def setup
    @theme_level = theme_levels(:level_1)
  end

  test "theme level should be valid" do
    assert @theme_level.valid?
  end

  test "level must be greater than 0" do
    @theme_level.level = -1
    assert_not @theme_level.valid?
  end

  test "name length should be less than 10 characters" do
    @theme_level.name = "a" * 11
    assert_not @theme_level.valid?
  end

  test "Theme level should have 2 subtheme" do
    assert_equal @theme_level.subthemes.count, 2
  end

  test "Theme level should have 2 theme level progress" do
    assert_equal @theme_level.theme_level_progresses.count, 2
  end

end
