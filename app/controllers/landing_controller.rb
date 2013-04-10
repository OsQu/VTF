class LandingController < ApplicationController
  layout "vtf"

  before_filter :authenticate_user!
  def index
  end
end
