require 'sinatra'
require './environment_helper'

class MySinatraApp < Sinatra::Application
	get EnvironmentHelper.route('hi') do
		"TODO: EXERCISES!"
	end
end
