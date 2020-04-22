Authentication helper methods - text reference and code
The code changes made during the previous video can be found here: https://github.com/udemyrailscourse/alpha-blog-6/commit/d154a5b0c53a05384e036623b4f8c4c56abc0e4b

Summary of changes:

- Added current_user and logged_in? helper methods.

- Modified the navigation partial and utilized these methods to display links based on logged in state.

- Modified the users controller create action so users' are logged in once they sign-up.

- Added set_user method and used it as before_action for show, edit and update actions in users controller.

