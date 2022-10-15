require "test_helper"

class DuelTest < ActiveSupport::TestCase
  def setup
    @duel = duels(:duel_1)
  end

  test "duel should be valid" do
    assert @duel.valid?
  end




end
