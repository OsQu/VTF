#!/usr/bin/ruby

require 'multi_json'
require './environment_helper'
require './database'

@DB.create_table? :users do
  primary_key :id
  String :name
  String :password_hash
end

@DB.create_table? :aphorisms do
  primary_key :id
  Integer :user_id
  String :author
  String :body
  TrueClass :published
end

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

