class Exercise < ActiveRecord::Base
  attr_accessible :description, :name, :category

  belongs_to :category
  validates :name, :presence => true
end
