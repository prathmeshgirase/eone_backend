class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :name
      t.string :password_digest
      t.string :mobile_number
      t.integer :status
      t.date :date_of_birth
      t.references :role, null: false, foreign_key: true

      t.timestamps
    end
  end
end
