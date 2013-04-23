require 'sequel'
require './environment_helper'
require 'digest'

@DB = Sequel.connect(:adapter => "postgres", :database => EnvironmentHelper.me)

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

class User < Sequel::Model
  one_to_many :aphorisms

  def self.authenticate(name, password)
    hash = Digest::MD5.hexdigest(password)
    puts hash
    User.first(name: name, password_hash: hash)
  end

  def self.register(name, password)
    if User[name: name]
      return nil
    end

    hash = Digest::MD5.hexdigest(password)
    User.create(name: name, password_hash: hash)
  end
end

class Aphorism < Sequel::Model
  many_to_one :user
end
