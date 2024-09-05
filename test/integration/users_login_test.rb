require "test_helper"

class UsersLoginTest < ActionDispatch::IntegrationTest
  
  def setup
    @user=users(:michael)
  end

  # test "正しいアドレスと誤ったパスワードでログインする" do
  #   get login_path
  #   assert_template 'session/new'
  #   post login_path, params: { session: {email:}}
  # end

  test '正しいアドレスと誤ったパスワードでログインする' do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: {session: {email: @user.email, password: "invalid"}}
    assert_response :unprocessable_entity
    assert_template 'sessions/new'
    assert_not flash.empty? # flashメッセージが空でないことをテスト
    get root_path
    assert flash.empty? # flashメッセージが空であることをテスト
  end
end
