require "test_helper"

class DuelQuizzQuestionTest < ActiveSupport::TestCase
  def setup
    @duel_quizz_question = duel_quizz_questions(:duel_quizz_question_1)
  end

  test "duel should be valid" do
    assert @duel_quizz_question.valid?
  end
end
