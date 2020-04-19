Lesson 138 New user signup form

To add the route for the new user signup page and the rest of the restful routes separately, add the following two lines to your routes.rb file:

get 'signup', to: 'users#new'
resources :users, except: [:new]
The changes made in the video in addition to the routes above are listed below (reference the commit for the specific code):

- Create users controller.

- Add new action along with initiating a new user instance variable.

- Create a users folder under app/views and add the new.html.erb template.

- Add a form partial, _form.html.erb, in the same folder.

- Update app/views/shared/_errors.html.erb and replace @article references with obj.

- Update app/views/articles/_form.html.erb and add obj: @article when rendering the errors partial.

Test out the form by going to /signup page and ensure it shows up.


