class User < ApplicationRecord
  belongs_to :role
  has_one :classroom, foreign_key: 'teacher_id', dependent: :destroy
  belongs_to :classroom, optional: true

  has_secure_password  # Enables password encryption

  enum status: { pending: 0, approved: 1, rejected: 2 }

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :name, presence: true
  validates :password, presence: true, length: { minimum: 6 }, if: -> { new_record? || !password.nil? }
  validates :mobile_number, uniqueness: true, allow_nil: true

  def api_response(token = nil)
    {
      email: email,
      name: name,
      mobile_number: mobile_number,
      status: status,
      date_of_birth: date_of_birth,
      role: role.name,
      classroom: classroom&.name,
      token: token
    }
  end
end
