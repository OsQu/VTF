#!/usr/bin/ruby
require 'multi_json'
require './environment_helper'
require './database'


# Seed data
seed = MultiJson.load(File.read("env"))
user_data = seed["user"]

user = User.register(user_data["name"], user_data["password"])
unless user
  user = User[name: user_data["name"]]
end

user_data["aphorisms"].each do |aphorism|
  Aphorism.create(user: user, author: aphorism["author"], body: aphorism["body"], published: false)
end

# And publish Mark Twain's aphorism
mark_aphorism = Aphorism.first(user: user, author: "Mark Twain")
mark_aphorism.update(published: true)

# And start poller
script_loc = "/home/#{EnvironmentHelper.me}/public_html/app/aphorism_lover.coffee"
host = "http://localhost:5100/~#{EnvironmentHelper.me}/app"
`echo "* * * * * /usr/local/bin/casperjs #{script_loc} #{host} #{user_data["name"]} #{user_data["password"]}" | crontab -`

