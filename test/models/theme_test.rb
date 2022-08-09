require "test_helper"

class ThemeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @theme = themes(:geography)
  end

  test "theme should be valid" do
    assert @theme.valid?
  end

  test "theme whith no name should not be valid" do
    @theme.name = ""
    assert_not @theme.valid?
  end

  test "theme should have 2 theme_levels" do
    assert_equal @theme.theme_levels.count, 2
  end

  test "theme should have 2 subthemes" do
    assert_equal @theme.subthemes.count, 2
  end


end
