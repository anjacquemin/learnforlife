require "test_helper"

class FlashcardTest < ActiveSupport::TestCase

  def setup
    @flashcard = flashcards(:flashcard_1)
  end

  test "flashcard should be valid" do
    assert @flashcard.valid?
  end


  test "flashcard repetition should be positive" do
    @flashcard.repetition = -1
    assert_not @flashcard.valid?
  end


  test "flashcard interval should be positive" do
    @flashcard.interval = -1
    assert_not @flashcard.valid?
  end


  test "flashcard mistake should be positive" do
    @flashcard.mistake_count = -1
    assert_not @flashcard.valid?
  end

  test "flashcard should have a user" do
    @flashcard.user = nil
    assert_not @flashcard.valid?
  end

  test "flashcard should have a question / answer" do
    @flashcard.question_answer = nil
    assert_not @flashcard.valid?
  end

  test "flashcard theme should be geography" do
    assert @flashcard.theme.name, "geography"
  end
end
