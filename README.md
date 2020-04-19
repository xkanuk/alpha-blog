To generate a migration to add the user_id column to articles table, you can use the command below:

$ rails generate migration add_user_id_to_articles

Then within the change method fill in the code specifying the change:

add_column :articles, :user_id, :int

Run the migration file to effect the change:

$ rails db:migrate

To form the association among the models, add the following line to article.rb model file:

belongs_to :user

And add the following line to user.rb model file:

has_many :articles

Ensure you have a couple of users in your users table created using the rails console. Then add in a line in the create action to temporarily grab and hardcode a user to each article that's created:

def create 
  @article = Article.new(article_params) 
  @article.user = User.first # <--- Add this line
  if @article.save 
    flash[:notice] = "Article was created successfully." 
    redirect_to @article 
  else 
    render 'new' 
  end 
end