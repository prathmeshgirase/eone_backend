class AssignmentBlueprint < Blueprinter::Base
  identifier :id

  fields :title, :description, :due_date, :subject_id, :teacher_id

  field :subject_name do |assignment|
    assignment.subject.name
  end

  field :teacher_name do |assignment|
    assignment.teacher&.name
  end

  field :file_url do |assignment|
    Rails.application.routes.url_helpers.url_for(assignment.file) if assignment.file.attached?
  end
end
