class Sandbox < ActiveRecord::Base
  attr_accessible :user, :exercise
  belongs_to :user
  belongs_to :exercise
end
