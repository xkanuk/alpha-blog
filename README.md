Edit Categories - Text directions and code
In the categories_controller.rb file create edit and update actions:

def edit

@category = Category.find(params[:id])

end

def update

@category = Category.find(params[:id])

if @category.update(category_params)

flash[:success] = "Category name was successfully updated"

redirect_to category_path(@category)

else

render 'edit'

end

end

Create a new partial _form.html.erb under app/views/categories folder and fill in the the code below(except the title, you can copy the rest of the code from the new.html.erb file):

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

Then update the new.html.erb in the same app/views/categories folder to look like below:

<h1 align="center">Create new category</h1>

<%= render 'form' %>

Create an edit.html.erb file under the same app/views/categories folder and fill it in:

<h1 align="center">Edit Category Name</h1>

<%= render 'form' %>

Update the show.html.erb template under the app/views/categories folder to display an edit category path:

<h1 align="center"><%= "Category: " + @category.name %></h1>

<div align="center">

<% if logged_in? and current_user.admin? %>

<div class="row">

<span class="badge"><%= link_to "Edit Category Name", edit_category_path(@category) %></span>

</div>

<% end %>

<%= will_paginate @category_articles %>

</div>

<%= render 'articles/article', obj: @category_articles %>

<div align="center">

<%= will_paginate @category_articles %>

</div>