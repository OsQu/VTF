require 'sinatra'
require 'haml'

require './database'
require './environment_helper'
require './authenticate'

enable :sessions

class Aphorisms < Sinatra::Application
  before do
    # Store errors from session to variable
    @errors = session[:errors] || {}
    session.delete(:errors)
  end

  get EnvironmentHelper.route(''), auth_required: true do
    @aphorisms = Aphorism.where(:published => true).all
    haml :index
  end

  get EnvironmentHelper.route('manage'), auth_required: true do
    @aphorisms = Aphorism.where(:user => @user)
    haml :manage
  end

  post EnvironmentHelper.route('manage'), auth_required: true do
    # This is actually an ajax call so return json
    if params[:aphorism].nil? || params[:aphorism].empty?
      status 400
      return "Invalid aphorism parameter"
    end

    if params[:published].nil? || params[:published].empty?
      status 400
      return "Invalid published parameter"
    end

    aphorism = Aphorism.where(:user => @user, :id => params[:aphorism])
    if aphorism.nil?
      status 404
      return "Could not found aphorism"
    end

    aphorism.update(published: params[:published])
    status 200
    "{\"published\": #{params[:published]}}"
  end

  post EnvironmentHelper.route("new-aphorism"), auth_required: true do
    # Validate
    errors = {}
    if params[:author].nil? || params[:author].empty?
      errors[:author] = "Author missing"
    end

    if params[:aphorism].nil? || params[:aphorism].empty?
      errors[:aphorism] = "Aphorism missing"
    end

    unless errors.empty?
      session[:errors] = errors
      redirect EnvironmentHelper.route("manage")
    end

    puts @user
    Aphorism.create(user: @user, author: params[:author], body: params[:aphorism], published: false)
    redirect EnvironmentHelper.route("manage")
  end
end
