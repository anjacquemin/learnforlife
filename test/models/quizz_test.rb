require "test_helper"

class QuizzTest < ActiveSupport::TestCase

  def setup
    @quizz = quizzs(:europe_capitales_1)
  end

  test "quizz should be valid" do
    assert @quizz.valid?
  end

  test "quizz should have a name" do
    @quizz.name = ""
    assert_not @quizz.valid?
  end

  test "quizz should have 2 quizz progresses" do
    assert_equal @quizz.quizz_progresses.count, 2
  end

  test "quizz should have 2 quizz levels" do
    assert_equal @quizz.quizz_levels.count, 2
  end

  test "quizz should have 2 quizz answers" do
    assert_equal @quizz.quizz_answers.count, 2
  end

  test "quizz should have 2 question answers" do
    assert_equal @quizz.question_answers.count, 2
  end


  test "quizz category should be capitale" do
    assert_equal @quizz.category.name, "capitale"
  end

  test "quizz theme should be geography" do
    assert_equal @quizz.theme.name, "geography"
  end
end
