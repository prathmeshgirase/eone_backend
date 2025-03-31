class CreateAssignments < ActiveRecord::Migration[7.1]
  def change
    create_table :assignments do |t|
      t.string :name
      t.string :file
      t.references :classroom, null: false, foreign_key: true

      t.timestamps
    end
  end
end
