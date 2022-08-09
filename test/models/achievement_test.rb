require "test_helper"

class AchievementTest < ActiveSupport::TestCase

  def setup
    @achievement = achievements(:achievement_1)
  end

  test "achievement should be valid" do
    assert @achievement.valid?
  end


  test "achievement should have a name" do
    @achievement.name = ""
    assert_not @achievement.valid?
  end


  test "achievement should have a description" do
    @achievement.description = ""
    assert_not @achievement.valid?
  end


  test "achievement should have a xp_to_win" do
    @achievement.xp_to_win = nil
    assert_not @achievement.valid?
  end

  test "xp_to_win should be positive or equal to 0" do
    @achievement.xp_to_win = -1
    assert_not @achievement.valid?
  end

  test "achievement should have several user_achievements" do
    assert @achievement.user_achievements
  end

end
