Restrict Actions from UI - Text directions and code
Updated and completed navigation partial:

<nav class="navbar navbar-default">

<div class="container-fluid">

<!-- Brand and toggle get grouped for better mobile display -->

<div class="navbar-header">

<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">

<span class="sr-only">Toggle navigation</span>

<span class="icon-bar"></span>

<span class="icon-bar"></span>

<span class="icon-bar"></span>

</button>

<%= link_to "Alpha blog", root_path, class: "navbar-brand", id: "logo" %>

</div>

<!-- Collect the nav links, forms, and other content for toggling -->

<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">

<ul class="nav navbar-nav">

<li><%= link_to "Articles", articles_path %></li>

<li><%= link_to "Users", users_path %></li>

<% if logged_in? %>

<li class="dropdown">

<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Actions <span class="caret"></span></a>

<ul class="dropdown-menu">

<li><%= link_to "New Article", new_article_path %></li>

<li><a href="#">Another action</a></li>

<li><a href="#">Something else here</a></li>

<li role="separator" class="divider"></li>

<li><a href="#">Separated link</a></li>

<li role="separator" class="divider"></li>

<li><a href="#">One more separated link</a></li>

</ul>

</li>

<% end %>

</ul>

<form class="navbar-form navbar-left" role="search">

<div class="form-group">

<input type="text" class="form-control" placeholder="Search">

</div>

<button type="submit" class="btn btn-default">Submit</button>

</form>

<ul class="nav navbar-nav navbar-right">

<% if logged_in? %>

<li><%= link_to 'Log out', logout_path, method: :delete %></li>

<li class="dropdown">

<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Your Profile<span class="caret"></span></a>

<ul class="dropdown-menu">

<li><%= link_to "Edit your profile", edit_user_path(current_user) %></li>

<li><%= link_to "View your profile", user_path(current_user) %></li>

<li><a href="#">Something else here</a></li>

<li role="separator" class="divider"></li>

<li><a href="#">Separated link</a></li>

</ul>

</li>

<% else %>

<li><%= link_to 'Log in', login_path %></li>

<li><%= link_to 'Sign up', signup_path %></li>

<% end %>

</ul>

</div><!-- /.navbar-collapse -->

</div><!-- /.container-fluid -->

</nav>

Updated home.html.erb in the app/views/pages folder:

<div class="center jumbotron">

<h1>ALPHA BLOG</h1>

<%= link_to "Sign up now", signup_path, class: "btn btn-danger btn-lg btn-xlarge" %>

</div>

Updated _article.html.erb partial in the app/views/articles folder with the logged in restrictions:

<% obj.each do |article| %>

<div class="row">

<div class="col-xs-8 col-xs-offset-2">

<div class="well well-lg">

<div class="article-title">

<%= link_to article.title, article_path(article) %>

</div>

<div class="article-body">

<%= truncate(article.description, length: 100) %>

<div class="article-meta-details">

<small>Created by: <%= article.user.username if article.user%>,

<%= time_ago_in_words(article.created_at) %> ago,

last updated: <%= time_ago_in_words(article.updated_at) %> ago</small>

</div>

</div>

<% if logged_in? && current_user == article.user %>

<div class="article-actions">

<%= link_to "Edit this article", edit_article_path(article), class: "btn btn-xs btn-primary" %>

<%= link_to "Delete this article", article_path(article), method: :delete,

data: { confirm: "Are you sure you want to delete the article?"},

class: "btn btn-xs btn-danger" %>

</div>

<% end %>

</div>

</div>

</div>

<% end %>

Updated show.html.erb (show articles) page in the app/views/articles folder:

<h2 align="center">Title: <%= @article.title %></h2>

<div class="well col-xs-8 col-xs-offset-2">

<% if @article.user %>

<ul class="listing">

<div class="row center">

<div class="col-md-4 col-md-offset-4">

<li>Created by:</li>

<li><%= link_to gravatar_for(@article.user), user_path(@article.user) %></li>

<li class="article-title">

<%= link_to @article.user.username, user_path(@article.user) %>

</li>

<li><small>

<%= pluralize(@article.user.articles.count, "article") if @article.user.articles %>

</small></li>

</div>

</div>

</ul>

<% end %>

<h4 class="center description"><strong>Description:</strong></h4>

<hr>

<%= simple_format(@article.description) %>

<div class="article-actions">

<% if logged_in? && current_user == @article.user %>

<%= link_to "Edit this article", edit_article_path(@article), class: "btn btn-xs btn-primary" %>

<%= link_to "Delete this article", article_path(@article), method: :delete,

data: { confirm: "Are you sure you want to delete the article?"},

class: "btn btn-xs btn-danger" %>

<% end %>

<%= link_to "View all articles", articles_path, class: "btn btn-xs btn-success" %>

</div>

</div>

Update the home action in the pages_controller.rb file to look like below:

def home

redirect_to articles_path if logged_in?

end

