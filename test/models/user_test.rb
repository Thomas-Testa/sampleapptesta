require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(email: "Rails@off.the",username: "railsman" password: "pass", password_cofirm: "pass", mobile: "0403013")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "Mobile be valid" do
    @user.mobile = "0" * 10
    assert_not @user.valid?
  end

  test "email should'nt be long" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end

  test "email validation should accept valid emails" do
    valid_addresses = %w[user@example.com TESTA@foo.COM THO-MAS@adn.jam.org]
    valid_addresses.each do |valid_addresses|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "unique email" do 
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end

end
