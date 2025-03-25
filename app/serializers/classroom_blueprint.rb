class ClassroomBlueprint < Blueprinter::Base
  identifier :id

  fields :name, :batch, :year

  field :teacher_name do |classroom|
    classroom.teacher&.name
  end
end
