class Notification < ApplicationRecord
  belongs_to :assignment, optional: true
  belongs_to :teacher, class_name: 'User', optional: true
  belongs_to :user, optional: true
end
