class CreateAssignmentSubmissions < ActiveRecord::Migration[7.1]
  def change
    create_table :assignment_submissions do |t|
      t.references :assignment, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :file

      t.timestamps
    end
  end
end
