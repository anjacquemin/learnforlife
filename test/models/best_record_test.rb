require "test_helper"

class BestRecordTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @best_record = best_records(:best_record_1)
  end

  test "best_record should be valid" do
    assert @best_record.valid?
  end

  test "best_record record / quizz level should have record " do
    @best_record.record = nil
    assert_not @best_record.valid?
  end

  test "best_record should have a quizz level" do
    @best_record.quizz_level = nil
    assert_not @best_record.valid?
  end

end
