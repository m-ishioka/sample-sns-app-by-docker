require 'test_helper'

class PostTest < ActiveSupport::TestCase
  setup do
    @post = posts(:one)
  end

  # 正常系
  test "post it" do
    assert @post.valid?
  end

  test "user id accepts duplicates" do
    duplicate_post = @post.dup
    duplicate_post.id = 4
    assert duplicate_post.valid?
  end

  # 準正常系
  test "content does not accept null" do
    @post.content = nil

    assert @post.invalid?
    assert_includes @post.errors[:content], "内容を入力してください。"
  end

  test "content does not accept more than 512 characters" do
    @post.content = "a" * 513

    assert @post.invalid?
    assert_includes @post.errors[:content], "内容は512文字以下で入力してください。"
  end

  # 異常系
  test "id does not accept strings" do
    @post = Post.new(id: '')
    assert @post.invalid?
  end

  test "id does not accept null" do
    @post = Post.new(id: nil)
    assert @post.invalid?
  end

  test "user id does not accept strings" do
    @post = Post.new(user_id: '')
    assert @post.invalid?
  end

  test "user id does not accept null" do
    @post = Post.new(user_id: nil)
    assert @post.invalid?
  end
end
