class SubmissionBlueprint < Blueprinter::Base
  identifier :id

  fields :student_name, :created_at, :file_url, :marks, :status

  field :student_name do |submission|
    submission.user.name
  end

  field :created_at do |submission|
    submission.created_at
  end

  field :file_url do |submission|
    Rails.application.routes.url_helpers.url_for(submission.file) if submission.file.attached?
  end

  field :status do |submission|
    submission.marks.nil? ? 'pending' : 'reviewed'
  end
end
