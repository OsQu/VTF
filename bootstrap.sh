#!/usr/bin/env bash

apt-get update

# Install and configure dependencies

# PostgreSql
if ! hash psql 2>/dev/null; then
  apt-get install -y postgresql
  sudo -u postgres createuser --superuser vagrant
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
