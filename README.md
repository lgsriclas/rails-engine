# Rails Engine

## Background and Description

"Rails Engine," is a Mod 3 i project at the Turing School of Software and Design, by Lesley Sanders. It is an e-commerce inspired API and provides clients with eleven endpoints.

The database is pre-seeded with merchants and their corresponding items.  

## Learning Goals
- Expose an API
- Use serializers to format JSON responses
- Test API exposure
- Use SQL and ActiveRecord to gather data

## Setup and Testing

This project utilizes Rails 5.2.6 and Ruby 2.7.2

* Fork this repository
* Clone your fork
* From the command line, install gems and set up your DB:
    * `bundle install`
    * `rails db:drop db:create db:migrate, db:seed`
    * `rails csv_load:all`
    * `rails db:schema:dump`
* Run the test suite with `bundle exec rspec`.
  * The RSpec test suite can be found in the project's spec directory.
* Run your development server with `rails s` to see the app in action.

## Contributers

- [Lesley Sanders](https://github.com/lgsriclas)
