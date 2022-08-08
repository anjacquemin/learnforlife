require "test_helper"

class ThemeLevelTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @theme = Theme.new(name: "Geography")
    @theme_level = ThemeLevel.new(name: "Niveau 1", objective: "Gagner la medaille de bronze", level: 1)
    @theme_level.theme = @theme
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

  test "objective length should be less than 140 characters" do
    @theme_level.objective = "a" * 141
    assert_not @theme_level.valid?
  end

end
