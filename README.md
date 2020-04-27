Integration Test and Feature: Create Category - Text directions and code
Under test/integration folder create a file named create_categories_test.rb which will be the integration test for creating categories and fill it in with the following:

require 'test_helper'

class CreateCategoriesTest < ActionDispatch::IntegrationTest

test "get new category form and create category" do

get new_category_path

assert_template 'categories/new'

assert_difference 'Category.count', 1 do

post_via_redirect categories_path, category: {name: "sports"}

# if using Rails 5 use below 2 lines instead of line above (without the comment tag of course):

# post categories_path, params: { category: { name: "sports" } }

# follow_redirect!

end

assert_template 'categories/index'

assert_match "sports", response.body

end

end

If using Rails 5, first add the gem 'rails-controller-testing' to your Gemfile and then run bundle install, also make note above of the line where you post to categories_path

Fill in the new.html.erb template under the app/views/categories folder:

<h1 align="center">Create new category</h1>

<%= render 'shared/errors', obj: @category %>

<%= form_for(@category, :html => {class: "form-horizontal", role: "form"}) do |f| %>

<div class="form-group">

<div class="control-label col-sm-2">

<%= f.label :name %>

</div>

<div class="col-sm-8">

<%= f.text_field :name, class: "form-control", placeholder: "Category name", autofocus: true %>

</div>

</div>

<div class="form-group">

<div class="col-sm-offset-2 col-sm-10">

<%= f.submit class: 'btn btn-primary btn-lg' %>

</div>

</div>

<% end %>

<div class="col-xs-4 col-xs-offset-4">

[ <%= link_to "Cancel request and return to articles listing", articles_path %> ]

</div>

Fill in the code in the categories_controller.rb file under the app/controllers folder:

class CategoriesController < ApplicationController

def index

@categories = Category.all

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

end

Fill in the categories index.html.erb view under the app/views/categories page:

<h1 align="center">Listing All Categories</h1>

<div align="center">

<% @categories.each do |category| %>

<ul class="listing">

<div class="row">

<div class="well col-md-4 col-md-offset-4">

<li class="article-title">

<%= link_to "#{category.name}", category_path(category) %>

</li>

</div>

</div>

</ul>

<% end %>

</div>