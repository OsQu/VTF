class SandboxesController < ApplicationController
  before_filter :authenticate_user!

  def show
    render text: "TODO"
  end

  def create
    sandbox = Sandbox.new user: current_user, exercise: sandbox_params[:exercise]
    if sandbox.save
      # Fire up the sandbox
      startup_script = Rails.root.join("app", "scripts", "setup_exercise.sh")
      unless Kernel.system("sudo #{startup_script}")
        render status: 500, text: "Failed to run startup_script"
        return
      end
    end
    render json: "{}"
  end

  def destroy
    render text: "TODO"
  end

  private

  def sandbox_params
    params.permit(:exercise)
  end
end
