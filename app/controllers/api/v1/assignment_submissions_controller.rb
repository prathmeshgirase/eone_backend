class Api::V1::AssignmentSubmissionsController < ApplicationController
  def create
    submission = AssignmentSubmission.new(submission_params)
    assignment = Assignment.find submission.assignment_id
    if submission.save
      user = User.find_by id: submission.user_id
      Notification.create(user_id: submission.user_id, assignment_id: submission.assignment_id, message: "#{user.name} has completed a assignment: #{assignment.title}. Please review it.")
      render json: { message: "Submission successful", submission: submission.as_json(methods: [:file_url], except: [:file]) }, status: :created
    else
      render json: { errors: submission.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    submission = AssignmentSubmission.find params[:id]
    submission.update(marks: params[:marks], grade: params[:grade])
    render json: { message: "Marks updated successfully", submission: SubmissionBlueprint.render_as_hash(submission) }, status: :ok
  end

  private

  def submission_params
    params.require(:assignment_submission).permit(:assignment_id, :user_id, :file)
  end
end
