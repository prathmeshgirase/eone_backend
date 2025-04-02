class  Api::V1::AssignmentsController < ApplicationController
  def create
    assignment = Assignment.new(assignment_params)

    if assignment.save
      render json: { message: "Assignment created successfully", assignment: assignment }, status: :created
    else
      render json: { errors: assignment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def index
    if params[:teacher_id].present?
      assignments = Assignment.where(teacher_id: params[:teacher_id])
      render json: AssignmentBlueprint.render_as_hash(assignments), status: :ok
    end
  end

  private

  def assignment_params
    params.require(:assignment).permit(:title, :description, :due_date, :subject_id, :teacher_id)
  end
end
