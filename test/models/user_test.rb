require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(username:"janedoe", email:"janedoe@example.com", password:"password")
  end

  test "user should be valid" do
    assert @user.valid?
  end

  test "username should be present" do
    @user.username = " "
    assert_not @user.valid?
  end

  test "username should be unique" do 
    @user.save
    user2 = User.new(username:"janedoe", email:"janedoe@example.com", password:"password")
    assert_not user2.valid?
  end

  test "username should not be too long" do 
    @user.username = "a" * 26
    assert_not @user.valid?
  end

  test "username should not be too short" do 
    @user.username ="a"
    assert_not @user.valid?
  end

  test "email should be unique" do 
    @user.save
    user2 = User.new(username:"janedoe", email:"janedoe@example.com", password:"password")
    assert_not user2.valid?
  end

  test "email should be correct format" do 
    @user.email = "example.com"
    assert_not @user.valid?
  end

  test "email should not be too long" do 
    @user.email = ("a" * 100) + "@example.com"
    assert_not @user.valid?
  end

  test "password should not be too short" do 
    @user.password = "1234567"
    assert_not @user.valid?
  end

end