class SubjectsController < ApplicationController
  # before_action :authenticate_user! # Ensure the user is logged in (if needed)

  def create
    subject = Subject.new(subject_params)

    if subject.save
      render json: { message: "Subject created successfully", subject: subject }, status: :created
    else
      render json: { errors: subject.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def subject_params
    params.require(:subject).permit(:name, :start_time, :end_time, :teacher_id, :classroom_id, days_list: [])
  end
end
