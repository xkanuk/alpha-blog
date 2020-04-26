Categories Controller and Tests - Text directions and code
Create a file named categories_controller_test.rb under the test/controllers folder and fill it in with the following:

require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase

def setup

@category = Category.create(name: "sports")

end

test "should get categories index" do

get :index

assert_response :success

end

test "should get new" do

get :new

assert_response :success

end

test "should get show" do

get(:show, {'id' => @category.id})

assert_response :success

end

end

If Rails 5, then use the following instead:

require 'test_helper'

class CategoriesControllerTest < ActionDispatch::IntegrationTest

def setup

@category = Category.create(name: "sports")

end

test "should get categories index" do

get categories_path

assert_response :success

end

test "should get new" do

get new_category_path

assert_response :success

end

test "should get show" do

get category_path(@category)

assert_response :success

end

end





Under app/controllers folder create a file named categories_controller.rb and fill it in:

class CategoriesController < ApplicationController

def index

end

def new

end

def show

end

end

In your config/routes.rb file add in the following route for categories:

resources :categories, except: [:destroy]

Under app/views folder create a folder called categories and create 3 files, new.html.erb, index.html.erb and show.html.erb