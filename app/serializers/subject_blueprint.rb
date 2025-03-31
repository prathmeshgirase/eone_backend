class SubjectBlueprint < Blueprinter::Base
  identifier :id

  fields :name, :days_list, :start_time, :end_time, :teacher_id, :classroom_id

  field :teacher_name do |subject|
    subject.teacher&.name
  end

  field :classroom_name do |subject|
    subject.classroom&.name
  end
end
