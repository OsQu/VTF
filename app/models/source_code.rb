class SourceCode < ActiveRecord::Base
  attr_accessible :body, :name
  belongs_to :exercise
end
