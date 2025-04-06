class  Api::V1::AssignmentsController < ApplicationController
  def create
    assignment = Assignment.new(assignment_params)

    if assignment.save
      render json: { message: "Assignment created successfully", assignment: assignment.as_json(except: [:file]) }, status: :created
    else
      render json: { errors: assignment.errors.full_messages }, status: :unprocessable_entity
    end
  rescue Exception => e
    render json: { errors: 'Unable to submit' }, status: :unprocessable_entity
  end

  def index
    if params[:teacher_id].present?
      assignments = Assignment.where(teacher_id: params[:teacher_id])
      render json: AssignmentBlueprint.render_as_hash(assignments), status: :ok
    elsif params[:student_id].present?
      student = User.find_by id: params[:student_id]
      classroom = student.classroom
      subject_ids = classroom.subjects.ids
      assignments = Assignment.where(subject_id: subject_ids)
      render json: AssignmentBlueprint.render_as_hash(assignments), status: :ok
    end
  end

  private

  def assignment_params
    params.require(:assignment).permit(:title, :description, :due_date, :subject_id, :file, :teacher_id)
  end
end
