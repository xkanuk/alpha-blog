require 'test_helper'

class CreateUserTest < ActionDispatch::IntegrationTest

  # def setup
  #   @user = User.create(username: "john", email: "john@example.com", password: "password", admin: true)
  # end

  test "get sign in form and create user" do 
    get signup_path
    assert_template 'users/new'
    assert_difference 'User.count', 1 do 
      post users_path, params: { user: { username: "janedoe", email: "janedoe@example.com", 
        password: "password" } }
      # follow_redirect!
      get users_path
    end
    assert_template 'users/index'
    assert_match "janedoe", response.body

  end

  test "invalid user submission results in failure" do 
    get signup_path
    assert_template 'users/new'
    assert_no_difference 'User.count' do 
      post users_path, params:{user:{username: " "}} 
    end
    assert_template 'users/new'
    assert_select 'h4.alert-heading'
  end
end