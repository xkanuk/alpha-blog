Restrict Actions in Controller - Text directions and code
Completed articles_controller.rb file:

class ArticlesController < ApplicationController

before_action :set_article, only: [:edit, :update, :show, :destroy]

before_action :require_user, except: [:index, :show]

before_action :require_same_user, only: [:edit, :update, :destroy]

def index

@articles = Article.paginate(page: params[:page], per_page: 5)

end

def new

@article = Article.new

end

def edit

end

def create

@article = Article.new(article_params)

@article.user = current_user

if @article.save

flash[:success] = "Article was successfully created"

redirect_to article_path(@article)

else

render 'new'

end

end

def update

if @article.update(article_params)

flash[:success] = "Article was successfully updated"

redirect_to article_path(@article)

else

render 'edit'

end

end

def show

end

def destroy

@article.destroy

flash[:danger] = "Article was successfully deleted"

redirect_to articles_path

end

private

def set_article

@article = Article.find(params[:id])

end

def article_params

params.require(:article).permit(:title, :description)

end

def require_same_user

if current_user != @article.user

flash[:danger] = "You can only edit or delete your own articles"

redirect_to root_path

end

end

end

Completed users_controller.rb file

class UsersController < ApplicationController

before_action :set_user, only: [:edit, :update, :show]

before_action :require_same_user, only: [:edit, :update]

def index

@users = User.paginate(page: params[:page], per_page: 5)

end

def new

@user = User.new

end

def create

@user = User.new(user_params)

if @user.save

flash[:success] = "Welcome to the alpha blog #{@user.username}"

redirect_to articles_path

else

render 'new'

end

end

def edit

end

def update

if @user.update(user_params)

flash[:success] = "Your account was updated successfully"

redirect_to articles_path

else

render 'edit'

end

end

def show

@user_articles = @user.articles.paginate(page: params[:page], per_page: 5)

end

private

def user_params

params.require(:user).permit(:username, :email, :password)

end

def set_user

@user = User.find(params[:id])

end

def require_same_user

if current_user != @user

flash[:danger] = "You can only edit your own account"

redirect_to root_path

end

end

end

To deploy to heroku, first ensure you have committed all your changes to your git repo, then:

git push heroku master

Then run any pending migrations in heroku:

heroku run rake db:migrate