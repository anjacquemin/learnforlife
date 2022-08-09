require "test_helper"

class QuizzAnswerTest < ActiveSupport::TestCase
  def setup
    @quizz_answers = quizz_answers(:quizz_answer_1)
  end

  test "answer should be valid" do
    assert @quizz_answers.valid?
  end

  test "quizz_answers should have 2 user_answer" do
    assert_equal @quizz_answers.user_answers.count, 2
  end
end
