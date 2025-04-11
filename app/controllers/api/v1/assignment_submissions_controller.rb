class Api::V1::AssignmentSubmissionsController < ApplicationController
  def create
    submission = AssignmentSubmission.new(submission_params)
    if submission.save
      Notification.create(assignment_id: submission.assignment_id, teacher_id: assignment.teacher_id, user_id: submission.user_id)
      render json: { message: "Submission successful", submission: submission.as_json(methods: [:file_url], except: [:file]) }, status: :created
    else
      render json: { errors: submission.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def submission_params
    params.require(:assignment_submission).permit(:assignment_id, :user_id, :file)
  end
end
