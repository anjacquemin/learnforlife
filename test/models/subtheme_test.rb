require "test_helper"

class SubthemeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @subtheme = subthemes(:europe)
  end

  test "subtheme should be valid" do
    assert @subtheme.valid?
  end

  test "subtheme should have a name" do
    @subtheme.name = ""
    assert_not @subtheme.valid?
  end

  test "subtheme should have 2 subtheme progress" do
    assert_equal @subtheme.subtheme_progresses.count, 2
  end

  test "theme of subtheme europe should be geography" do
    assert_equal @subtheme.theme.name, "geography"
  end

end
