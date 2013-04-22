class Exercise < ActiveRecord::Base
  attr_accessible :description, :name, :parameterized_name

  belongs_to :category
  has_many :sandboxes
  has_many :source_codes

  validates :name, :presence => true
  validates :parameterized_name, :format => { :with => /\A[a-z]+\z/, :message => "Only lowcase letters are allowed"}
end
