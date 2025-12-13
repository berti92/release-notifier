class AddActiveUntil < ActiveRecord::Migration[7.0]
  def up
    add_column :accounts, :active_until, :date
  end
end
