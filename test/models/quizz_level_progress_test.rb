require "test_helper"

class QuizzLevelProgressTest < ActiveSupport::TestCase
  def setup
    @quizz_level_progress_1 = quizz_level_progresses(:europe_capitales_1_quizz_level_1_progress_1)
  end

  test "quizz_level progress should be valid" do
    assert @quizz_level_progress_1.valid?
  end

  test "quizz_level progress should have a user" do
    @quizz_level_progress_1.user = nil
    assert_not @quizz_level_progress_1.valid?
  end

  test "quizz_level progress should have a quizz_level" do
    @quizz_level_progress_1.quizz_level = nil
    assert_not @quizz_level_progress_1.valid?
  end

  test "quizz_level progress should have 1 theme : geography" do
    assert_equal @quizz_level_progress_1.theme.name, "geography"
  end

end
