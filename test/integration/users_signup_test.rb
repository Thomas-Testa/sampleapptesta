require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  
  def setup
    ActionMailer::Base.deliveries.clear
  end
  
  test "valid signup information" do 
    get signup_path
    assert_difference 'User.count', 1 do 
      post users_path, params: {user: {email:"walker@alcho.com",username:"JohnyWalker",
                              password:"password", password_confirmation:"password", mobile: "04823928"} }
    end
    follow_redirect!
    assert_template'users/show'
    assert is_logged_in?

  end
end
