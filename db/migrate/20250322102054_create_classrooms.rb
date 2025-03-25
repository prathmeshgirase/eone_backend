class CreateClassrooms < ActiveRecord::Migration[7.0]
  def change
    create_table :classrooms do |t|
      t.string :name, null: false
      t.references :teacher, foreign_key: { to_table: :users } # References users table
      t.boolean :is_active, default: true, null: false

      t.timestamps
    end
  end
end
