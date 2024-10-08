require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: 'Example User', email: 'user@example.com',
                     password: 'password', password_confirmation: 'password')
  end

  test 'should be valid' do
    assert @user.valid?, "#{@user.email}"
  end
  test 'name should be present' do
    @user.name = ''
    assert_not @user.valid?
  end

  test 'email should be present' do
    @user.email = ''
    assert_not @user.valid?
  end

  test 'name should not be too long' do
    @user.name = 'a' * 51
    assert_not @user.valid?
  end

  test 'email should not be too long' do
    @user.email = 'b' * 255 + '@example.com'
    assert_not @user.valid?
  end

  test 'email validation should accept valid addresses' do
    valid_addresses = ['user@example.com', 'USER@foo.COM', 'A_US-ER@foo.bar.org',
                       'first.last@foo.jp', 'alice+bob@baz.cn']
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test 'email validation should reject invalid addresses' do
    invalid_addresses = ['user@example,com', 'user_at_foo.org', 'user.name@example.',
                         'foo@bar_baz.com', 'foo@bar+baz.com']
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test 'emailアドレスはユニークでなくてはならない' do
    dupulicate_user = @user.dup
    dupulicate_user_email = @user.email.upcase
    @user.save
    assert_not dupulicate_user.valid?
  end

  test 'emailアドレスは小文字として保存されなくてはならない' do
    mixed_case_email = 'Foo@ExAMPle.CoM'
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test 'パスワードは0文字以上でなくてはならない' do
    @user.password = @user.password_confirmation = ' ' * 8
    assert_not @user.valid?, "#{@user.name}"
  end

  test 'パスワードは最小長が決まっている' do
    @user.password = @user.password_confirmation = 'a' * 7
    assert_not @user.valid?, "#{@user.password}"
  end
end
