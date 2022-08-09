require "test_helper"

class UserAnswerTest < ActiveSupport::TestCase

  def setup
    @user_answer = user_answers(:user_answer_1)
  end

  test "user answer should be valid" do
    assert @user_answer.valid?
  end

end
