Add Admin User - Text directions and code
To generate a migration and add the admin column to users table:

rails generate migration add_admin_to_users

Within the migration file, in the def change method, add in the following code:

add_column :users, :admin, :boolean, default: false

Then run rake db:migrate to run the migration file and add the column to the users table:

rake db:migrate

Jump on rails console and you can grab a user object and set the user to admin by setting their admin column to true:

user = User.find(idofuser)

or

user = User.last or User.first or User.find_by(email: "emailofuser")

user.admin?

user.toggle!(:admin)

Then user.admin? # should be true at this point

Update require_same_user method in the articles_controller.rb file:

def require_same_user

if current_user != @article.user and !current_user.admin?

flash[:danger] = "You can only edit or delete your own articles"

redirect_to root_path

end

end

Then proceed to articles views, in the _article.html.erb partial under the app/views/articles folder, update the line where you're checking for <% if logged_in? &&....%> to:

<% if logged_in? && (current_user == article.user || current_user.admin?) %>

Make the same update to the show.html.erb file under app/views/articles folder:

<% if logged_in? && (current_user == article.user || current_user.admin?) %>

In _navigation.html.erb partial under app/views/layouts folder add admin next to where you display Your Profile:

Your Profile <%= "Admin" if current_user.admin? %>