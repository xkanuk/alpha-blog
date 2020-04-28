Build Article and Category Association - Text directions and code
To generate a migration file to create the article_categories table:

rails generate migration create_article_categories

Within the migration file add in the following to add article_id and category_id to the table:

t.integer :article_id

t.integer :category_id

Run rake db:migrate to create the table:

rake db:migrate

Create a model file named article_category.rb under the app/models folder and fill it in:

class ArticleCategory < ActiveRecord::Base

# Note Rails 5 -> class ArticleCategory < ApplicationRecord

belongs_to :article

belongs_to :category

end

Update the article.rb and category.rb model files to include the following lines:

article.rb ->

has_many :article_categories

has_many :categories, through: :article_categories

category.rb ->

has_many :article_categories

has_many :articles, through: :article_categories

Then hop on the rails console and test out the associations:

ArticleCategory.all

ArticleCategory

article = Article.last

category = Category.last

article.categories

article.categories << category

category.articles

category.articles << article