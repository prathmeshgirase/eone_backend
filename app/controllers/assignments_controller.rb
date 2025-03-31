class AssignmentsController < ApplicationController
  def create
    assignment = Assignment.new(assignment_params)

    if assignment.save
      render json: { message: "Assignment created successfully", assignment: assignment }, status: :created
    else
      render json: { errors: assignment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def assignment_params
    params.require(:assignment).permit(:title, :description, :due_date, :file, :subject_id)
  end
end
