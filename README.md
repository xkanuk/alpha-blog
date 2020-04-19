Add user-article association
- remember to edit model so that 
  - user has many articles
  - article belongs to a user 
    - or something like that

View articles - newest first

Validations for User class:

- username must be present and unique, length between 3 and 25 characters

- email must be present and unique, length max of 105 characters

- validate email format using regex (regular expression)
The ruby regular expression used to match the format of valid email addresses is listed below.

/\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
