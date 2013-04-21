class SandboxesController < ApplicationController
  before_filter :authenticate_user!

  def show
    render text: "TODO"
  end

  def create
    unless sandbox = Sandbox.where(user_id: current_user, exercise_id: exercise).first
      sandbox = Sandbox.new user: current_user, exercise: exercise
      if sandbox.save
        # Fire up the sandbox
        startup_script = Rails.root.join("app", "scripts", "setup_exercise.sh")
        unless Kernel.system("sudo #{startup_script} #{current_user.username} #{sandbox.exercise.parameterized_name}")
          render status: 500, text: "Failed to run startup_script"
          return
        end
      end
    end
    render json: MultiJson.dump({ sandbox: sandbox.url})
  end

  def destroy
    render text: "TODO"
  end

  private

  def exercise
    Exercise.find sandbox_params[:exercise_id]
  end

  def sandbox_params
    params.permit(:exercise_id)
  end
end
