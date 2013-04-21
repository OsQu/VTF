#!/usr/bin/ruby

require 'pg'
require './environment_helper'

def with_database_connection
  conn = PG::Connection.open(dbname: EnvironmentHelper.me)
  yield(conn)
  conn.finish
end

# Create secrets table
secrets_query = "
  CREATE TABLE secrets(
    id          serial,
    customer    varchar(255) NOT NULL,
    name        varchar(255) NOT NULL,
    secret      varchar(255) NOT NULL
  );"

with_database_connection do |c|
  c.exec(secrets_query)
end

# Insert the answer
vip_secret_query = "
  INSERT INTO secrets(customer, name, secret)
  VALUES('vip', 'very secret', $1);"

answer = IO.read('answer.txt')

with_database_connection do |c|
  c.exec(vip_secret_query, [answer.strip])
end
