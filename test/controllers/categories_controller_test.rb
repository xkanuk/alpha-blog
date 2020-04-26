require 'test_helper'

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @category = Category.create(name: "sports")
  end

  test "should get categories_path" do
    get categories_path
    assert_response :success
  end

  test "should get new_category_path" do 
    get new_category_path
    assert_response :success
  end

  test "should get category_path" do 
    get category_path(@category)
    assert_response :success
  end

end
