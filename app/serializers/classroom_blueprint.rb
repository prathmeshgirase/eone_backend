class ClassroomBlueprint < Blueprinter::Base
  identifier :id

  fields :batch, :year

  field :teacher_name do |classroom|
    classroom.teacher&.name
  end

  field :name do |classroom|
    classroom.name + classroom.batch + classroom.year
  end
end
