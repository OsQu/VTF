require 'spec_helper'

describe User do
  describe "email validation so that correct username can be created" do
    it "should allow test.guy@gmail.com" do
      user = User.new email: "test.guy@gmail.com", password: "verysecret"
      user.save.should be_true
    end

    it "should not allow 123@gmail.com" do
      user = User.new email: "123@gmail.com", password: "verysecret"
      user.save.should be_false
    end

    it "should not allow ...@gmail.com" do
      user = User.new email: "...@gmail.com", password: "verysecret"
      user.save.should be_false
    end

    it "should not allow @gmail.com" do
      user = User.new email: "@gmail.com", password: "verysecret"
      user.save.should be_false
    end
  end

  it "should generate username from email" do
    user = User.new email: "test.mail@gmail.com", password: "verysecret"
    user.save!

    user.username.should eq("testmail")
  end
end
