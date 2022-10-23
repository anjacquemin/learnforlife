require "test_helper"

class DuelQuizzTest < ActiveSupport::TestCase
  def setup
    @duel_quizz = duel_quizzs(:duel_quizz_1)
  end

  test "duel should be valid" do
    assert @duel_quizz.valid?
  end
end
