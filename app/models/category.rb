class Category < ActiveRecord::Base
  has_many :exercises
  attr_accessible :name
end
