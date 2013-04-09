class Exercise < ActiveRecord::Base
  CATEGORIES = %w(SQL-Injection XSS CSRF Missing\ HTTPS)

  attr_accessible :description, :name, :category

  validates :name, :presence => true
  validates :category, :inclusion => { :in => CATEGORIES, :message => "%{value} is not correct category" }
end
