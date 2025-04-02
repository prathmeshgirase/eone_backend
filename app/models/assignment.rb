class Assignment < ApplicationRecord
  belongs_to :subject
  belongs_to :teacher, class_name: 'User'

  # has_one_attached :file  # Active Storage for file uploads

  validates :title, presence: true

  def file_url
    Rails.application.routes.url_helpers.rails_blob_url(file, only_path: true) if file.attached?
  end
end
