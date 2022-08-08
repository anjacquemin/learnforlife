require "test_helper"

class ThemeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @theme = Theme.new(name: "geography" )
  end

  test "theme should be valid" do
    assert @theme.valid?
  end

  test "theme whith no name should not be valid" do
    @theme.name = ""
    assert_not @theme.valid?
  end

  test "theme should have several theme_levels" do
    (1..3).each do |i|
      theme_level = ThemeLevel.new(name: "Niveau #{i}", objective: "Gagner la medaille de bronze #{i}", level: i)
      theme_level.theme = @theme
      theme_level.save
    end
    assert_equal @theme.theme_levels.count, 3
  end

end
