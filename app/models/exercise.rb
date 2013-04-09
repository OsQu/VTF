class Exercise < ActiveRecord::Base
  attr_accessible :description, :name

  belongs_to :category
  validates :name, :presence => true
end
