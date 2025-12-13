class CreateNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table :notifications do |t|
      t.string  :name, null: false
      t.integer :repo_type, null: false
      t.text    :repo, null: false
      t.string  :email
      t.text    :webhook_url
      t.string  :webhook_method
      t.string  :webhook_content_type
      t.text    :webhook_payload
      t.string  :last_release
      t.belongs_to :account
      t.belongs_to :repository
      t.timestamps
    end
  end
end
