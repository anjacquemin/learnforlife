require "test_helper"

class UserAchievementTest < ActiveSupport::TestCase

  def setup
    @achievement = user_achievements(:user_achievement_1)
  end

  test "achievement should be valid" do
    assert @achievement.valid?
  end
end
