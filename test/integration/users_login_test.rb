require "test_helper"

class UsersLogin < ActionDispatch::IntegrationTest
  
  def setup
    @user=users(:michael)
  end
end

class InvalidPasswordTest < UsersLogin
   
  test "login_path" do 
    get login_path
    assert_template 'sessions/new'
  end

  test "有効なemailと無効なパスワードでログインする" do
    post login_path, params: {session: {email: @user.email, password: "invalid"}}
    assert_not is_logged_in?
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end
end

class ValidLogin < UsersLogin
  
  def setup
    super
    post login_path, params: {session:{email: @user.email, password: 'password'}}
  end
end

class Logout < ValidLogin

  def setup
    super
    delete logout_path
  end
end

class LogoutTest < Logout

  test "ログアウトに成功する" do
    assert_not is_logged_in?
    assert_response :see_other
    assert_redirected_to root_url
  end

  test "ログアウト後のリダイレクト" do
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path, count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
  end
end
  