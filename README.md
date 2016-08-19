[ ![Codeship Status](https://codeship.com/projects/e2942930-e86e-0133-a8e1-46bb3aa6b241/status?branch=master)](https://codeship.com/projects/147224)
![Code Climate](https://codeclimate.com/github/bmordas11/politick.png)
[![Coverage Status](https://coveralls.io/repos/github/bmordas11/politick/badge.svg?branch=master)](https://coveralls.io/github/bmordas11/politick?branch=master)

# politick

## A site to help voters stay informed about elections and politicians

The Heroku link:
http://politick.herokuapp.com/

Info about this app:

* Ruby version - (ruby 2.3.0)

* Configuration (Puma web server, Devise user authentication)

* Database creation (PostgreSQL database)

* Database initialization
  - bundle exec rake db:create
  - bundle exec rake db:migrate

* How to run the test suite:
  - bundle (to make sure you have the correct gems)
  - export RAILS_ENV=test
  - bundle exec rake db:schema:load
  - bundle exec rake or bundle exec rspec spec (either will run the test suite)

* Services
  - pg_search gem -> search function to search through all politicians
  - Ability to comment on any politician (when logged in)
  - Ability to upvote or downvote any comment made (when logged in)

* Deployment instructions:
  - Production: git push heroku master
  - Development: bundle exec rails s (localhost:3000)
