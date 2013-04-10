require 'spec_helper'

describe ExercisesController do
  before :each do
    @user = FactoryGirl.create :user
    sign_in @user
  end

  describe "GET /exercises/:id" do
    before :each do
      category = FactoryGirl.create :category_with_exercises, exercise_count: 3
      @exercise = category.exercises.first

      get :show, id: @exercise.id
    end

    it "should return 200" do
      response.status.should eq(200)
    end

    it "should assign active exercise" do
      assigns[:active_exercise].should eq(@exercise)
    end

    it "should assign " do
      assigns[:exercise].should eq(@exercise)
    end
  end
end
