require "test_helper"

class QuizzProgressTest < ActiveSupport::TestCase
  def setup
    @quizz_progress_1 = quizz_progresses(:capitale_progress_1)
  end

  test "quizz progress should be valid" do
    assert @quizz_progress_1.valid?, "errors: #{@quizz_progress_1.errors.messages}"
  end

  test "quizz progress should have a user" do
    @quizz_progress_1.user = nil
    assert_not @quizz_progress_1.valid?
  end

  test "quizz progress should have a quizz" do
    @quizz_progress_1.quizz = nil
    assert_not @quizz_progress_1.valid?
  end

  test "quizz progress should have 1 theme : geography" do
    assert_equal @quizz_progress_1.theme.name, "geography"
  end
end
