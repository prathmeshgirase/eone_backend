class AssignmentSubmissionsController < ApplicationController
  def create
    submission = AssignmentSubmission.new(submission_params)
    
    if submission.save
      render json: { message: "Submission successful", submission: submission }, status: :created
    else
      render json: { errors: submission.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def submission_params
    params.require(:assignment_submission).permit(:assignment_id, :user_id, :file)
  end
end
