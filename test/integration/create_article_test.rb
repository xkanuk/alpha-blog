require 'test_helper'

class CreateArticleTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.create(username: "john", email: "john@example.com", password: "password", admin: true)
  end

  test "get new article form and create article" do 
    sign_in_as(@user, "password")
    get new_article_path
    assert_template 'articles/new'
    assert_difference 'Article.count', 1 do 
      post articles_path, params:{ article:{ title: "test article",
        description: "description of test article",
        user_id: User.first.id } } 
      follow_redirect!
    end
    assert_template 'articles/show'
    assert_match "test article", response.body
  end

  test "invalid article submission results in failure" do 
    sign_in_as(@user, "password")
    get new_article_path
    assert_template 'articles/new'
    assert_no_difference 'Article.count' do 
      post articles_path, params:{ article: {title: " " } } 
    end
    assert_template 'articles/new'
    assert_select 'h4.alert-heading'
  end
end