require "application_system_test_case"

class CommentsTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers
  
  setup do
    @comment = comments(:one)
    @post = posts(:one)
    @user = users(:one)
    sign_in(@user)
  end

  test "should create comment" do
    visit post_url(@post)
    click_on "ツイートにコメントする"

    fill_in "comment[content]", with: @comment.content
    click_on "投稿する"

    assert_text "コメントしました"
    click_on "タイムラインに戻る"
  end

  test "does not create comment by emtpy content" do
    visit post_url(@post)
    click_on "ツイートにコメントする"

    fill_in "comment[content]", with: ''
    click_on "投稿する"

    assert_selector "h2", text: "コメントの投稿に失敗しました。"
    assert_selector "li", text: "Content内容を入力してください。"
    click_on "タイムラインに戻る"
  end

    test "does not create comment over length content" do
    visit post_url(@post)
    click_on "ツイートにコメントする"

    fill_in "comment[content]", with: 'a' * 513
    click_on "投稿する"

    assert_selector "h2", text: "コメントの投稿に失敗しました。"
    assert_selector "li", text: "Content内容は512文字以下で入力してください。"
    click_on "タイムラインに戻る"
  end

  test "should update Comment" do
    visit comment_url(@comment)
    click_on "コメントを編集する", match: :first

    fill_in "comment[content]", with: @comment.content
    click_on "更新する"

    assert_text "コメントを更新しました"
    click_on "タイムラインに戻る"
  end

  test "does not update Comment" do
    visit comment_url(@comment)
    click_on "コメントを編集する", match: :first

    fill_in "comment[content]", with: ''
    click_on "更新する"

    assert_selector "h2", text: "コメントの投稿に失敗しました。"
    assert_selector "li", text: "Content内容を入力してください。"
    click_on "タイムラインに戻る"
  end

  test "should destroy Comment" do
    visit comment_url(@comment)
    click_on "このコメントを削除する", match: :first

    assert_text "コメントを削除しました"
  end
end
