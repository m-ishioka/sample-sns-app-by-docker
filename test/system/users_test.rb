require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers
  
  setup do
    @user = users(:one)
  end

  test "visiting the signin" do
    visit "/users/sign_in"
    assert_selector "h2", text: "ログイン"
  end

  test "visiting the signup" do
    visit "/users/sign_up"
    assert_selector "h2", text: "サインアップ"
  end

  test "visiting the signined redirect timeline" do
    sign_in(@user)
    visit "/users/sign_in"
    assert_selector "h1", text: "タイムライン"
  end

  test "visiting the signup redirect timeline" do
    sign_in(@user)
    visit "/users/sign_up"
    assert_selector "h1", text: "タイムライン"
  end

  test "should sign in" do
    visit "/users/sign_in"
    assert_selector "h2", text: "ログイン"

    fill_in "user[email]", with: @user.email
    fill_in "user[password]", with: "password"
    click_on "ログイン"

    assert_text "ログインしました。"
    click_on "ログアウト"
    assert_selector "h2", text: "ログイン"
  end

  test "does not sign in by empty" do
    visit "/users/sign_in"
    assert_selector "h2", text: "ログイン"
    
    click_on "ログイン"

    assert_selector "article", text: "Eメールまたはパスワードが違います。"
  end

  test "does not sign in by no match inputs" do
    visit "/users/sign_in"
    assert_selector "h2", text: "ログイン"
    
    fill_in "user[email]", with: "test22@test.co.jp"
    fill_in "user[password]", with: "a" * 10
    click_on "ログイン"

    assert_selector "article", text: "Eメールまたはパスワードが違います。"
  end

  test "should sign up" do
    visit "/users/sign_up"
    assert_selector "h2", text: "サインアップ"
    
    fill_in "user[email]", with: "test1@test.co.jp"
    fill_in "user[password]", with: "password"
    fill_in "user[password_confirmation]", with: "password"
    click_on "サインアップ"

    assert_text "アカウント登録が完了しました。"
    click_on "ログアウト"
    assert_selector "h2", text: "ログイン"
  end

  test "does not sign up" do
    visit "/users/sign_up"
    assert_selector "h2", text: "サインアップ"
    
    fill_in "user[email]", with: @user.email
    fill_in "user[password]", with: "password"
    fill_in "user[password_confirmation]", with: "password"
    click_on "サインアップ"

    assert_selector "h2", text: "エラーが発生したため ユーザー は保存されませんでした。"
    assert_selector "li", text: "Eメールこのメールアドレスは既に登録されています。"
  end

  test "does not sign up by empty" do
    visit "/users/sign_up"
    assert_selector "h2", text: "サインアップ"
    
    click_on "サインアップ"

    assert_selector "h2", text: "2 件のエラーが発生したため ユーザー は保存されませんでした。"
    assert_selector "li", text: "Eメールメールアドレスを入力してください。"
    assert_selector "li", text: "パスワードパスワードを入力してください。"
  end

  test "does not sign up by confrict password" do
    visit "/users/sign_up"
    assert_selector "h2", text: "サインアップ"
    
    fill_in "user[email]", with: "test2@test.co.jp"
    fill_in "user[password]", with: "a" * 6
    fill_in "user[password_confirmation]", with:  "a" * 7
    click_on "サインアップ"

    assert_selector "h2", text: "エラーが発生したため ユーザー は保存されませんでした。"
    assert_selector "li", text: "パスワード（確認用）パスワードが一致しません。"
  end

  test "does not sign up by min length password" do
    visit "/users/sign_up"
    assert_selector "h2", text: "サインアップ"
    
    fill_in "user[email]", with: "test2@test.co.jp"
    fill_in "user[password]", with: "a" * 5
    fill_in "user[password_confirmation]", with:  "a" * 5
    click_on "サインアップ"

    assert_selector "h2", text: "エラーが発生したため ユーザー は保存されませんでした。"
    assert_selector "li", text: "パスワードパスワードは6文字以上で入力してください。"
  end
end
