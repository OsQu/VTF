class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :assign_categories # Categories are needed on every page unless explicitely told so

  def assign_categories
    @categories = Category.all
  end
end
