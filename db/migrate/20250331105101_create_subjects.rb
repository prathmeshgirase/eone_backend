class CreateSubjects < ActiveRecord::Migration[7.0]
  def change
    create_table :subjects do |t|
      t.string :name
      t.string :days_list, array: true, default: []
      t.string :start_time
      t.string :end_time
      t.references :teacher, foreign_key: { to_table: :users }
      t.references :classroom, foreign_key: true

      t.timestamps
    end
  end
end
