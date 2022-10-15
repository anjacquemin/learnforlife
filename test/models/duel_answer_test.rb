require "test_helper"

class DuelAnswerTest < ActiveSupport::TestCase
  def setup
    @duel_answer = duel_answers(:duel_answer_1)
  end

  test "duel should be valid" do
    assert @duel_answer.valid?
  end
end
