class CreateAssignments < ActiveRecord::Migration[7.1]
  def change
    create_table :assignments do |t|
      t.string :title
      t.text :description
      t.date :due_date
      t.string :file
      t.references :subject, null: false, foreign_key: true

      t.timestamps
    end
  end
end
