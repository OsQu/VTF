require 'spec_helper'

describe Sandbox do
  before :each do
    @user = FactoryGirl.create :user
    @exercise = FactoryGirl.create :exercise
  end

  it "should be able to create connection from user and exercise" do
    expect {
      Sandbox.create user: @user, exercise: @exercise
    }.to change{Sandbox.count}.by(1)
  end
end
