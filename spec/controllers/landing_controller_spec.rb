require 'spec_helper'

describe LandingController do
  before :each do
    @user = FactoryGirl.create :user
    sign_in @user
  end

  it "should do something" do
    get :index
    response.status.should eq(200)
  end
end
