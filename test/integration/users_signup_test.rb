require "test_helper"

class UsersSignupTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "無効なサインアップ情報" do
    get signup_path
    assert_no_difference "User.count" do
      post users_path, params: {user: {name: "user2",
                                      email: "user2@example.com",
                                      passowrd: "password",
                                      password_confirmation: "password"}} 
    end
    assert_response :unprocessable_entity
    assert_template 'users/new'
  end

  test "有効なサインアップ情報" do
    assert_difference "User.count", 1 do
      post users_path, params: {user: {name: "test",
                                      email: "test@example.com",
                                      password: "password",
                                      password_confirmation: "password"}}
    end
    follow_redirect!
    assert_template 'users/show'
  end
end