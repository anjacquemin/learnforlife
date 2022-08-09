require "test_helper"

class SubthemeProgressTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @subtheme_progress_1 = subtheme_progresses(:subtheme_progress_1)
  end

  test "theme level progress should be valid" do
    assert @subtheme_progress_1.valid?, "errors: #{@subtheme_progress_1.errors.messages}"
  end

  test "theme level progress should have a user" do
    @subtheme_progress_1.user = nil
    assert_not @subtheme_progress_1.valid?
  end

  test "theme level progress should have a theme level" do
    @subtheme_progress_1.subtheme = nil
    assert_not @subtheme_progress_1.valid?
  end
end
