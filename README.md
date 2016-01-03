Bookmark Manager Challenge
==================

Author: Emma Beynon

Github: https://github.com/emmabeynon

Email: emma.beynon@gmail.com


This is my submission for the Makers Academy Week 4 Project: https://github.com/makersacademy/course/tree/master/bookmark_manager

Overview
---------
This project involves creating a Bookmark Manager, where users can maintain a collection of links.  The links are organised by tags, and users can create an account in order to manage their own links.  During the course of the project I have explored relational databases and user management.  Technology used includes DataMapper, SQL, Capybara, Sinatra and Heroku.

User Stories
------------
```
As a time-pressed user
So that I can quickly go to web sites I regularly visit
I would like to see a list of links on the homepage

As a time-pressed user
So that I can quickly find web sites I recently bookmarked
I would like to see links in descending chronological order

As a time-pressed user
So that I can save a website
I would like to add the site's address and title to my bookmark manager

As a time-pressed user
So that I can organise my many links into different categories for ease of search
I would like to add tags to the links in my bookmark manager

As a time-pressed user
So that I can quickly find links on a particular topic
I would like to filter links by tag
```

Instructions
------------
You can view the original app here: http://bookmark-manager-eb.herokuapp.com/users/new

Alternatively, follow these instructions to create your own:

1. Fork this repo and clone to your local machine.
2. Run ```gem install bundle```
3. Once installation is complete, run ```bundle```
4. Create a .env file in your root directory and input ```RACK_ENV=development```.  Make sure you add this file to .gitignore.
5. Run ```psql``` and create the following databases: ```bookmark_manager_development```, ```bookmark_manager_test```.
6. To view locally, run ```rackup``` or use your preferred interface. View at: http://localhost:9292/user/new
7. To run on Heroku, create your app by running ```heroku create bookmark-manager-example```. Push to Heroku using ```git push heroku master``` and add the postgresql add-on to your app using this command ```heroku addons:create heroku-postgresql:hobby-dev```.

Approach
---------
To start off the project, I used psql to create two SQL databases (one for development, and one for testing) and employed DataMapper to manipulate it via a Ruby interface.  I created a Link class to create new links which maps to the database using DataMapper.  Then I started to build a modular Sinatra app in order to for the user to create and view links.  The development of the app was test-driven using Capybara, and DatabaseCleaner was used to clear the database between tests to ensure that the outcomes of tests is always reliable.  With users now being able to create and view their links, I developed functionality for them to organise and filter their links using tags.  This involved setting up a many-to-many relationship between the links and tags, and enabling users to add tags when they create their links.  This was later extended to handle adding multiple tags to a link.  

Now that a single user could use the bookmark manager, it was time to extend this to multiple users by creating user accounts.  I created a form for user to sign up using their name, email address and a password.  The password is validated against a password confirmation to ensure it is correct, and then stored securely as a salted hash in the database using BCrypt.  If the password and password confirmation do not match, a Sinatra Flash error message appears and the user cannot proceed.  Additionally, if the user provides a blank or incorrectly formatted email address then further error messages appear.  Finally, functionality was added to prevent users from signing up with an already registered email address.

With the database now capable of holding multiple user information, I looked at creating a sign in form to enable users to access their links.  A welcome message is displayed after signing in successfully.  The User class authenticate the user by looking up their email address and comparing a hashed version of the password entered with the hashed password in the database, and prevents sign in if they don't match. Finally, users are able to log out by clicking a 'Sign out' button, after which a 'Goodbye message' is displayed.

Further Work
-------------
* Complete steps 26 & 27.
* Ensure that a user can only view their own links.
* Improve user flow through the site e.g. homepage should have a log in form and link to sign up.
* Show links in descending chronological order.
* Add tags to links retroactively.
* Create a dropdown filter for tags.
