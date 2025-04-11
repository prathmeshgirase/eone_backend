class AddFieldsToNotifications < ActiveRecord::Migration[7.1]
  def change
    add_column :notifications, :message, :string
    add_column :notifications, :read_at, :datetime
  end
end
