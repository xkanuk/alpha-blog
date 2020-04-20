Lesson 142  Edit users - text directions and code

All the code changes made in the video are available here: https://github.com/udemyrailscourse/alpha-blog-6/commit/e247a7b0d8e52ddd71ac0571a2cb1d6cae2e1906

To look for a specific keyword in search results from a command issued in the terminal, you can use the pipe operator followed by grep. In the video we looked for 'edit' from rails routes using the command below:

$ rails routes --expanded | grep edit

Summary of the changes made to add the edit existing user functionality are listed below (check out the repo for specific code):

- Add the edit and update actions in users controller.

- Add the edit.html.erb template under app/views/users folder.

- Update the form partial under app/views/users folder to accommodate different button text to display based on if the record being worked on is a new record (new template) or existing record (edit template).

