class AddGradeToSubmission < ActiveRecord::Migration[7.1]
  def change
    add_column :assignment_submissions, :grade, :string
  end
end
