VTS
===

Vulnerability Test Field web-software for my Bachelor's Thesis

Requirements
------------

* Ruby 1.9.3
* Bundler
* PostgreSql

Installation
------------
Copy `config/database.yml.config` to `~/.vtf/database.yml` and edit to have correct data

Add databases (for example setup):

    createdb vtf
    createdb vtf-test

Install all the dependencies:

    bundle install

Initialize databases using rake:

    bundle exec rake db:setup

Also let's initialize test environment database:

    RAILS_ENV=test bundle exec db:setup

Running
-------

    bundle exec rails server

Testing
-------

    bundle exec rspec spec

Deployment
----------

TODO: Figure out
