require "application_system_test_case"

class PostsTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers
  
  setup do
    @post = posts(:one)
    @user = users(:one)
    sign_in(@user)
  end

  test "visiting the index" do
    visit posts_url
    assert_selector "h1", text: "タイムライン"
  end

  test "should create post" do
    visit posts_url
    click_on "新しくツイートする"

    fill_in "post[content]", with: @post.content
    click_on "投稿する"

    assert_text "ツイートしました"
    click_on "タイムラインに戻る"
  end

  test "does not create post by emtpy content" do
    visit posts_url
    click_on "新しくツイートする"

    fill_in "post[content]", with: ''
    click_on "投稿する"

    assert_selector "h2", text: "ツイートの投稿に失敗しました。"
    assert_selector "li", text: "Content内容を入力してください。"
    click_on "タイムラインに戻る"
  end

  test "does not create post by over length content" do
    visit posts_url
    click_on "新しくツイートする"

    fill_in "post[content]", with: 'a' * 513
    click_on "投稿する"

    assert_selector "h2", text: "ツイートの投稿に失敗しました。"
    assert_selector "li", text: "Content内容は512文字以下で入力してください。"
    click_on "タイムラインに戻る"
  end

  test "should update Post" do
    visit post_url(@post)
    click_on "ツイートを編集する", match: :first

    fill_in "post[content]", with: @post.content
    click_on "更新する"

    assert_text "ツイートを更新しました"
    click_on "タイムラインに戻る"
  end

  test "does not update Post" do
    visit post_url(@post)
    click_on "ツイートを編集する", match: :first

    fill_in "post[content]", with: ''
    click_on "更新する"

    assert_selector "h2", text: "ツイートの投稿に失敗しました。"
    assert_selector "li", text: "Content内容を入力してください。"
    click_on "タイムラインに戻る"
  end

  test "should destroy Post" do
    visit post_url(@post)
    click_on "ツイートを削除する", match: :first

    assert_text "ツイートを削除しました"
  end
end
