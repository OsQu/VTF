VTF
===

Vulnerability Test Field web-software for my Bachelor's Thesis

Requirements
------------

* Ruby 1.9.3
* Bundler
* PostgreSql

Installation
------------

### Using VirtualBox and Vagrant

Just install [VirtualBox](https://www.virtualbox.org/) and
[Vagrant](http://www.vagrantup.com/) and run:

    vagrant up

Vagrant mounts current folder as a `/vagrant` folder in quest machine, so ssh to
virtual machine with `vagrant ssh` and move to that directory: `cd /vagrant`

### Manually

Here are instructions how to set up VTF manually:

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


Adding exercises
----------------

First, create exercise locally using your favourite development tools.

When the exercise is ready to deployed, do the following:

1. Create new folder to exercises: `mkdir exercises/<my exercise>`. Exercise
   name must match the username rules.
2. Add folder structure `public_html/app` to the exercise folder: `mkdir -p exercises/<my exercise>/public_html/app`
3. Move exercise files to the `app` folder.
4. Convert your setup script to bash script by renaming it to `.sh` and adding correct [shebang](http://en.wikipedia.org/wiki/Shebang_(Unix))
5. Copy `.htaccess` and `dispatch.fcgi` from sample exercise to the exercise and edit to suit the exercise.
6. Modify your exercise to fit the "production" system: Move static files to static/ folder and serve them from there etc.

TODO: Explain all the different "magic files"

Running
-------

    bundle exec rails server

Testing
-------

    bundle exec rspec spec

Deployment
----------

TODO: Figure out
