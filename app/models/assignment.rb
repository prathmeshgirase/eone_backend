class Assignment < ApplicationRecord
  belongs_to :classroom

  has_one_attached :file  # Active Storage for file uploads

  validates :name, presence: true

  def file_url
    Rails.application.routes.url_helpers.rails_blob_url(file, only_path: true) if file.attached?
  end
end
