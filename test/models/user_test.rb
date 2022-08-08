require "test_helper"

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @user = user.new(name: "anthony",email: "anthony@mail.com" , password: "foobar" , password_confirmation: "foobar" )
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = "      "
    assert_not @user.valid?
  end

  test "name should not be too long" do
    @user.name = "a" * 15
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a" * 244 + "@mail.com"
    assert_not @user.valid?
  end

  test "email validation should reject invalid addresses" do
  invalid_adresses = %[user@example,com user_at_foo.org user.name@example.
  foo@bar_baz.com foo@bar+baz.com foo@barbaz...com]
    invalid_adresses.each do |invalid_address|
      @user.email = address
      assert_not user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "email addresses should be unique" do
    duplicate_user = user.duplicate_user
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
    assert_not user.valid?
  end

  test "password should have minimum length" do
    @user.password = @user.password_confirmation =  "a" * 5
    assert_not user.valid?
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
    assert_equal @user.reload.level, 0
  end

end
