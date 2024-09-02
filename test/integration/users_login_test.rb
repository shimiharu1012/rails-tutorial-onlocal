require "test_helper"

class UsersLoginTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test 'ログイン時の情報が誤りになる' do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: {session: {email: ""}}
    assert_response :unprocessable_entity
    assert_template 'sessions/new'
    assert_not flash.empty? # flashメッセージが空でないことをテスト
    get root_path
    assert flash.empty? # flashメッセージが空であることをテスト
  end
end
