require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  setup do
    @comment = comments(:one)
  end

  # 正常系
  test "comment it" do
    assert @comment.valid?
  end

  test "user id and post id accepts duplicates" do
    duplicate_comment = @comment.dup
    duplicate_comment.id = 3
    assert duplicate_comment.valid?
  end

  # 準正常系
  test "content does not accept null" do
    @comment.content = nil

    assert @comment.invalid?
    assert_includes @comment.errors[:content], "内容を入力してください。"
  end

  test "content does not accept more than 512 characters" do
    @comment.content = "a" * 513

    assert @comment.invalid?
    assert_includes @comment.errors[:content], "内容は512文字以下で入力してください。"
  end

  # 異常系
  test "id does not accept strings" do
    @comment = Comment.new(id: '')
    assert @comment.invalid?
  end

  test "id does not accept null" do
    @comment = Comment.new(id: nil)
    assert @comment.invalid?
  end

  test "user id does not accept strings" do
    @comment = Comment.new(user_id: '')
    assert @comment.invalid?
  end

  test "user id does not accept null" do
    @comment = Comment.new(user_id: nil)
    assert @comment.invalid?
  end

  test "post id does not accept strings" do
    @comment = Comment.new(post_id: '')
    assert @comment.invalid?
  end

  test "post id does not accept null" do
    @comment = Comment.new(post_id: nil)
    assert @comment.invalid?
  end
end
