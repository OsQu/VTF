class ExercisesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :assign_active_exercise

  def show
    @exercise = @active_exercise
  end

  def assign_active_exercise
    @active_exercise = Exercise.find(exercise_params[:id])
  end

  def exercise_params
    params.permit(:id)
  end
end
