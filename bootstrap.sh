#!/usr/bin/env bash

apt-get update

# Install and configure dependencies


# PostgreSql
if ! hash psql 2>/dev/null; then
  apt-get install -y postgresql
  sudo -u postgres createuser --superuser vagrant
  sudo -u postgres createuser --superuser root
fi

# Bundler

if ! hash bundler 2>/dev/null; then
  gem install bundler
fi

cd /vagrant

# Install dependencies

# These are needed for native extensions
apt-get install -y ruby1.9.1-dev
apt-get install -y libpq-dev

bundle install

# Configure databases for VTF

if [ ! -d /home/vagrant/.vtf ]; then
  sudo -u vagrant mkdir /home/vagrant/.vtf
  sudo -u vagrant cp config/database.yml.example /home/vagrant/.vtf/database.yml
  # Replace the placeholder user with vagrant
  sed -i s/manny/vagrant/ /home/vagrant/.vtf/database.yml

  sudo -u vagrant createdb vtf
  sudo -u vagrant createdb vtf-test
fi

sudo -u vagrant HOME=/home/vagrant bundle exec rake db:setup
sudo -u vagrant HOME=/home/vagrant RAILS_ENV=test bundle exec rake db:setup

# Set up virtual environment for exercises
apt-get install -y apache2 apache2-suexec libapache2-mod-fcgid
a2enmod userdir
a2enmod suexec
a2enmod rewrite

if [ ! -f /etc/apache2/sites-available/vtf ]; then
  cp vtf.site /etc/apache2/sites-available/vtf
fi

a2dissite default
a2ensite vtf
service apache2 restart

# Exercise frameworks. Since exercises are pretty tricky to setup, just install
# them globally.
apt-get install -y libfcgi-dev
gem install fcgi
gem install sinatra
