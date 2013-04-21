class Sandbox < ActiveRecord::Base
  attr_accessible :user, :exercise
  belongs_to :user
  belongs_to :exercise

  def url
    "#{ENV['SANDBOX_URL']}/~#{user.username}#{exercise.parameterized_name}/app"
  end
end
