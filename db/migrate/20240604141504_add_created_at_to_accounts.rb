class AddCreatedAtToAccounts < ActiveRecord::Migration[7.0]
  def change
    add_column :accounts, :created_at, :timestamp, null: false, default: -> { 'now()' }
  end
end
