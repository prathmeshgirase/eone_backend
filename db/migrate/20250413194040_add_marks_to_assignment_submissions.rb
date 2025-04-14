class AddMarksToAssignmentSubmissions < ActiveRecord::Migration[7.1]
  def change
    add_column :assignment_submissions, :marks, :integer
  end
end
