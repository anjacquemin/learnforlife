require "test_helper"

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @user = User.new(name: "anthony",email: "anthony@mail.com" , password: "foobar" , password_confirmation: "foobar", level: levels(:level1) )
    @user2 = users(:anthony)
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = "      "
    assert_not @user.valid?
  end

  test "name should not be too long" do
    @user.name = "a" * 16
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a" * 247 + "@mail.com"
    assert_not @user.valid?
  end

  test "email validation should reject invalid addresses" do
    invalid_adresses = %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com foo@barbaz...com]
    invalid_adresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "email addresses should be unique" do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end

  test "email adresses should be saved as lower case" do
    mixed_case_email = "AnThOnY@GMAil.COm"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test "password should be present" do
    @user.password = @user.password_confirmation =  " " * 6
    assert_not @user.valid?
  end

  test "password should have minimum length" do
    @user.password = @user.password_confirmation =  "a" * 5
    assert_not @user.valid?
  end

  test "hp should be set to 50 hp" do
    @user.save
    assert_equal @user.reload.hp, 50
  end

  test "gold should be set to 0" do
    @user.save
    assert_equal @user.reload.gold, 0
  end

  test "gem should be set to 0" do
    @user.save
    assert_equal @user.reload.gem, 0
  end

  test "xp should be set to 0" do
    @user.save
    assert_equal @user.reload.xp, 0
  end

  test "lvl should be set to 1" do
    @user.save
    assert_equal @user.reload.level.level, 1
  end

  test "user should have flashcards" do
    assert @user.flashcards
  end

  test "user should have theme_level_progresses" do
    assert @user.theme_level_progresses
  end

  test "user should have subtheme_progresses" do
    assert @user.subtheme_progresses
  end

  test "user should have category_progresses" do
    assert @user.category_progresses
  end

  test "user should have quizz_progresses" do
    assert @user.quizz_progresses
  end

  test "user should have quizz_level_progresses" do
    assert @user.quizz_level_progresses
  end

  test "user should have records" do
    assert @user.records
  end

  test "user should have quizz_answers" do
    assert @user.records
  end

  test "user should have user_answers" do
    assert @user.user_answers
  end

  test "user should have several achievements" do
    assert @user.achievements
  end

  test "user should have several user_achievements" do
    assert @user.user_achievements
  end
end
