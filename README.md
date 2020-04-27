Integration Test for Invalid Category - Text directions and code
Add the following test to your create_categories_test.rb file under test/integration folder:

test "invalid category submission results in failure" do

get new_category_path

assert_template 'categories/new'

assert_no_difference 'Category.count' do

post categories_path, category: {name: " "}

# If using Rails 5, use below line instead of above

# post categories_path, params: { category: {name: " "} }

end

assert_template 'categories/new'

assert_select 'h2.panel-title'

assert_select 'div.panel-body'

end