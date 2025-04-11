class Assignment < ApplicationRecord
  belongs_to :subject
  belongs_to :teacher, class_name: 'User'
  has_many :assignment_submissions
  has_many :users, through: :assignment_submissions
  has_many :notifications

  has_one_attached :file  # Active Storage for file uploads

  validates :title, presence: true

  def file_url
    Rails.application.routes.url_helpers.url_for(file) if file.attached?
  end
end
