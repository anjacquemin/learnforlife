require "test_helper"

class RecordTest < ActiveSupport::TestCase
  require "test_helper"

  class RecordTest < ActiveSupport::TestCase

    def setup
      @record = records(:record_1)
    end

    test "record should be valid" do
      assert @record.valid?
    end

    test "record crown_or_sphere should be crown or sphere" do
      @record.crown_or_sphere = nil
      assert_not @record.valid?
      @record.crown_or_sphere = "crow"
      assert_not @record.valid?
    end

    test "record completion should be between 0 and 3" do
      @record.completion = nil
      assert_not @record.valid?
      @record.completion = -1
      assert_not @record.valid?
      @record.completion = 4
      assert_not @record.valid?
    end

    test "record should have a user" do
      @record.user = nil
      assert_not @record.valid?
    end

    test "record should have a quizz level" do
      @record.quizz_level = nil
      assert_not @record.valid?
    end

    test "record should have 1 theme : geography" do
      assert_equal @record.theme.name, "geography"
    end

  end

end
