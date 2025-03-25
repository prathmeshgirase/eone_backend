class UserBlueprint < Blueprinter::Base
  identifier :id

  fields :email, :name, :mobile_number, :status, :date_of_birth

  field :role do |user|
    user.role.name
  end

  field :classroom do |user|
    user.classroom&.name
  end
end
