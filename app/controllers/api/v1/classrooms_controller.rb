class Api::V1::ClassroomsController < ApplicationController
  def index
    render json: ClassroomBlueprint.render(Classroom.all), status: :ok
  end

  def create
    classroom = Classroom.new(classroom_params)

    if classroom.save
      render json: { message: "Classroom created successfully", classroom: { id: classroom.id, name: classroom.name } }, status: :created
    else
      render json: { error: classroom.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def classroom_params
    params.require(:classroom).permit(:name, :batch, :year)
  end
end
