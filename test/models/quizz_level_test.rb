require "test_helper"

class QuizzLevelTest < ActiveSupport::TestCase

  def setup
    @quizz_level = quizz_levels(:europe_capitales_1_quizz_level_1)
  end

  test "quizz_level should be valid" do
    assert @quizz_level.valid?
  end

  test "quizz_level should have a name" do
    @quizz_level.name = ""
    assert_not @quizz_level.valid?
  end

  test "quizz_level should have 2 quizz_level progresses" do
    assert_equal @quizz_level.quizz_level_progresses.count, 2
  end

  test "quizz_level should have 2 records" do
    assert_equal @quizz_level.records.count, 2
  end

  test "quizz_level quizz name should be capitale 1" do
    assert_equal @quizz_level.quizz.name, "capitale 1"
  end

  test "quizz_level theme should be geography" do
    assert_equal @quizz_level.theme.name, "geography"
  end

end
