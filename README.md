Admin User Requirement and Test - Text directions and code
Update categories_controller_test.rb file to create admin user and then simulate log in:

require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase

def setup

@category = Category.create(name: "sports")

@user = User.create(username: "john", email: "john@example.com", password: "password", admin: true)

end

test "should get categories index" do

get :index

assert_response :success

end

test "should get new" do

session[:user_id] = @user.id

get :new

assert_response :success

end

test "should get show" do

get(:show, {'id' => @category.id})

assert_response :success

end

test "should redirect create when admin not logged in" do

assert_no_difference 'Category.count' do

post :create, category: { name: "sports" }

end

assert_redirected_to categories_path

end

end

If using Rails 5, use below instead:

require 'test_helper'

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @category = Category.create(name: "Sports")
    @user = User.create(username: "john", email: "john@example.com", password: "password", admin: true)
  end
  
  test "should get categories index" do
    get categories_path
    assert_response :success
  end
  
  test "should get new" do
    sign_in_as(@user, "password")
    get new_category_path
    assert_response :success
  end
  
  test "should get show" do
    get category_path(@category)
    assert_response :success
  end
  
  test "should redirect create when admin not logged in" do
    assert_no_difference 'Category.count' do
      post categories_path, params: { category: { name: "sports" } }
    end
    assert_redirected_to categories_path
  end
end

Continuing with Rails 5 specific directions, in the test_helper.rb file you'll need to add sign_in_as method as follows 

  def sign_in_as(user, password)
    post login_path, params: { session: { email: user.email, password: password } }
  end

---- X -----

Back to regular directions:

Add code to require logged in admin users to categories_controller.rb file:

class CategoriesController < ApplicationController

before_action :require_admin, except: [:index, :show]

def index

@categories = Category.paginate(page: params[:page], per_page: 5)

end

def new

@category = Category.new

end

def create

@category = Category.new(category_params)

if @category.save

flash[:success] = "Category was created successfully"

redirect_to categories_path

else

render 'new'

end

end

def show

end

private

def category_params

params.require(:category).permit(:name)

end

def require_admin

if !logged_in? || (logged_in? and !current_user.admin?)

flash[:danger] = "Only admins can perform that action"

redirect_to categories_path

end

end

end