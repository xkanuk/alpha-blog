Update Tests and Navbar - Text directions and code
Update the create_categories_test.rb integration test file under test/integration folder to sign in an admin user:

require 'test_helper'

class CreateCategoriesTest < ActionDispatch::IntegrationTest

def setup

@user = User.create(username: "john", email: "john@example.com", password: "password", admin: true)

end

test "get new category form and create category" do

sign_in_as(@user, "password")

get new_category_path

assert_template 'categories/new'

assert_difference 'Category.count', 1 do

post_via_redirect categories_path, category: {name: "sports"}

# Note the line above was different for Rails 5

end

assert_template 'categories/index'

assert_match "sports", response.body

end

test "invalid category submission results in failure" do

sign_in_as(@user, "password")

get new_category_path

assert_template 'categories/new'

assert_no_difference 'Category.count' do

post categories_path, category: {name: " "}

# Note the line above was different for Rails 5

end

assert_template 'categories/new'

assert_select 'h2.panel-title'

assert_select 'div.panel-body'

end

end

Add sign_in_user method to test_helper.rb file under test folder:

def sign_in_as(user, password)

post login_path, session: {email: user.email, password: password}

end

If using Rails 5, you had already added this method in the previous video, it looked slightly different (shown below):

def sign_in_as(user, password)
   post login_path, params: { session: { email: user.email, password: password } }
end

Update the navigation partial to display categories including restrictions based on admin user for new categories path by adding the following code right under the <% end %> block for Actions and above the </ul> tag:

<li class="dropdown">

<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Categories <span class="caret"></span></a>

<ul class="dropdown-menu">

<li><%= link_to "All Categories", categories_path %></li>

<% Category.all.each do |category| %>

<li><%= link_to "#{category.name}", category_path(category) %></li>

<% end %>

<% if logged_in? and current_user.admin? %>

<li role="separator" class="divider"></li>

<li><%= link_to "Create New Category", new_category_path %></li>

<% end %>

</ul>

</li>