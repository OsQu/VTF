require 'spec_helper'

describe SandboxesController do
  before :each do
    Kernel.stub(:system).and_return(true)
    @user = FactoryGirl.create :user
    sign_in @user
  end

  describe "#create" do
    before :each do
      @exercise = FactoryGirl.create :exercise
    end

    it "should create sandbox model" do
      expect {
        post :create, exercise_id: @exercise
      }.to change{Sandbox.count}.by(1)
    end

    it "should call setup script with command line" do
      script_location = Rails.root.join("app","scripts", "setup_exercise.sh")
      Kernel.should_receive(:system)
        .with("sudo #{script_location} #{@user.username} #{@exercise.parameterized_name}")
        .and_return(false)

      post :create, exercise_id: @exercise
    end

    it "should return url for sandbox" do
      post :create, exercise_id: @exercise
      response.status.should eq(200)
      body = MultiJson.load(response.body)
      body['sandbox'].should eq("#{ENV['SANDBOX_URL']}/~#{@user.username}#{@exercise.parameterized_name}/app")
    end

    it "should return 500 if running the startup script failed" do
      Kernel.should_receive(:system).and_return(false)

      post :create, exercise_id: @exercise
      response.status.should eq(500)
    end

    it "should not create sandbox twice" do
      expect {
        post :create, exercise_id: @exercise
        post :create, exercise_id: @exercise
      }.to change{Sandbox.count}.by(1)
    end

  end
end
