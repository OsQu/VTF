require 'sinatra'
require 'haml'
require 'pg'

require './environment_helper'

class AcmeVault < Sinatra::Application
  enable :sessions # For routing to index with errors

  get EnvironmentHelper.route('') do
      @errors = session[:errors] if session.has_key?(:errors)
      session[:errors] = {}
      haml :index
  end

  post EnvironmentHelper.route('store') do
      # Validate parameters
      errors = {:store => []}
      name = params['name']
      secret = params['secret']
      if name.nil? || name.empty?
        errors[:store] << "Name is missing"
      end

      if secret.nil? || secret.empty?
        errors[:store] << "Secret is missing"
      end

      unless errors[:store].empty?
        session[:errors] = errors
        redirect to(EnvironmentHelper.route(''))
      end

      # Store secret
      with_database_connection do |conn|
        conn.exec("INSERT INTO secrets(customer, name, secret) VALUES('#{EnvironmentHelper.me}', '#{name}', '#{secret}');")
      end

      @home = EnvironmentHelper.route('')
      haml :stored
  end

  get EnvironmentHelper.route('find') do
    # Validate parameter
    errors = {:find => []}
    @name = params['name']
    if @name.nil? || @name.empty?
      errors[:find ] << "Name is missing"
    end

    unless errors[:find].empty?
      session[:errors] = errors
      redirect to(EnvironmentHelper.route(''))
    end

    # Find secrets
    res = nil
    with_database_connection do |conn|
      res = conn.exec("SELECT name, secret FROM secrets WHERE customer = '#{EnvironmentHelper.me}' AND name = '#{@name}';")
    end

    @secrets = res.values

    haml :find
  end

  def with_database_connection
    conn = PG::Connection.open(dbname: EnvironmentHelper.me)
    yield(conn)
    conn.finish
  end
end
