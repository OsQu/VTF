require 'spec_helper'

describe SandboxesController do
  before :each do
    Kernel.stub(:system).and_return(true)
    @user = FactoryGirl.create :user
    sign_in @user
  end

  describe "#create" do
    context "without env file" do
      before :each do
        File.stub(:exists).and_return(false)
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

    context "with env file" do
      before :each do
        @exercise = FactoryGirl.create :exercise, name: "Test", parameterized_name: "test"
      end

      after :each do
        test_envfile = Rails.root.join("tmp", "sandboxenvs", "#{@user.username}test")
        File.delete(test_envfile) if File.exists?(test_envfile)
      end

      it "should copy env file to tmp/sandboxenvs" do
        post :create, exercise_id: @exercise
        File.exists?(sandboxenv_path(@exercise)).should be_true
      end

      it "should replace RAND with some random string" do
        post :create, exercise_id: @exercise
        contents = File.read sandboxenv_path(@exercise)
        contents.include?("RAND").should be_false
      end

      it "should store env contents to sandbox" do
        post :create, exercise_id: @exercise

        sandbox = Sandbox.where(user_id: @user, exercise_id: @exercise).first
        env = File.read sandboxenv_path(@exercise)
        sandbox.env.should eq(env)
      end

      def sandboxenv_path(exercise)
        Rails.root.join("tmp", "sandboxenvs", "#{@user.username}#{exercise.parameterized_name}")
      end
    end
  end
end
