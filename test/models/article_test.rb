require 'test_helper'

class ArticleTest < ActiveSupport::TestCase

  def setup
    @user = User.create(username: "john", email: "john@example.com", password: "password", admin: true)
    @article = Article.new(title:"test article", description: "description of test article", user_id: User.last.id)
  end
    
  test "article should be valid" do
    assert @article.valid?
  end

  test "title should be present" do
    @article.title = " "
    @article.description = "test description"
    assert_not @article.valid?
  end

  test "description should be present" do
    @article.title = "test article"
    @article.description = " "
    assert_not @article.valid?
  end

end