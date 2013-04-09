require 'spec_helper'

describe LandingController do
  before :each do
    @user = FactoryGirl.create :user
    sign_in @user
  end

  describe "GET index" do
    before :each do
      @xss_category = FactoryGirl.create :category_with_exercises, name: "XSS"
      @csrf_category = FactoryGirl.create :category_with_exercises, name: "CSRF"
    end

    it "assigns all the categories" do
      get :index
      assigns[:categories].should include(@xss_category, @csrf_category)
    end

    it "returns 200" do
      get :index
      response.status.should eq(200)
    end
  end
end
