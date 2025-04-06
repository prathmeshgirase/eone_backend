class AssignmentSubmission < ApplicationRecord
  belongs_to :assignment
  belongs_to :user

  has_one_attached :file  # Uses Active Storage

  def file_url
    Rails.application.routes.url_helpers.url_for(file) if file.attached?
  end
end
