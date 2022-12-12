require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
  end

  # 正常系
  test "user it" do
    assert @user.valid?
  end

  # 準正常系
  test "email does not accept duplicates" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email
    assert_not duplicate_user.valid?
  end

  # 異常系
  test "id does not accept strings" do
    @user = User.new(id: '')
    assert @user.invalid?
  end

  test "id does not accept null" do
    @user = User.new(id: nil)
    assert @user.invalid?
  end

  test "id does not accept duplicates" do
    duplicate_user = @user.dup
    duplicate_user.id = @user.id
    assert_not duplicate_user.valid?
  end
end
