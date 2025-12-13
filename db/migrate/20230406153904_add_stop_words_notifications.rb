class AddStopWordsNotifications < ActiveRecord::Migration[7.0]
  def change
    add_column :notifications, :stop_words, :string
  end
end
