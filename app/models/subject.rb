class Subject < ApplicationRecord
  belongs_to :teacher, class_name: "User"
  belongs_to :classroom
end
