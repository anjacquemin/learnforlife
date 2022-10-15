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

  test "achievement should have several user_achievements" do
    assert @achievement.user_achievements
  end

end
