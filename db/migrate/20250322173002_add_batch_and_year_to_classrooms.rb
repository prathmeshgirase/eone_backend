class AddBatchAndYearToClassrooms < ActiveRecord::Migration[7.1]
  def change
    add_column :classrooms, :batch, :string
    add_column :classrooms, :year, :string
  end
end
