require "test_helper"

class QuestionAnswerTest < ActiveSupport::TestCase
  require "test_helper"

  def setup
    @question_answer = question_answers(:question_answer_1)
  end

  test "question_answer should be valid" do
    assert @question_answer.valid?
  end

  test "question_answer should have an answer" do
    @question_answer.answer = ""
    assert_not @question_answer.valid?
  end

  test "question_answer should have a question" do
    @question_answer.question = ""
    assert_not @question_answer.valid?
  end

  test "question_answer have user_answers" do
    assert @question_answer.user_answers
  end
end
