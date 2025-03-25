class Classroom < ApplicationRecord
  belongs_to :teacher, class_name: 'User', optional: true
  has_many :students, class_name: 'User', foreign_key: 'classroom_id'

  validates :name, presence: true, uniqueness: true
  validates :is_active, inclusion: { in: [true, false] }
end
