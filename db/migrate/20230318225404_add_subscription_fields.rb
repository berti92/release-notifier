class AddSubscriptionFields < ActiveRecord::Migration[7.0]
  def up
    add_column :accounts, :subscription_id, :int
    add_column :accounts, :subscription_state, :string
    add_column :accounts, :subscription_update_url, :string
    add_column :accounts, :subscription_cancel_url, :string
    add_column :accounts, :last_payment_date, :date
    add_column :accounts, :last_payment_value, :decimal, precision: 10, scale: 2
    add_column :accounts, :last_payment_currency, :string
    add_column :accounts, :next_payment_date, :date
    add_column :accounts, :next_payment_value, :decimal, precision: 10, scale: 2
    add_column :accounts, :next_payment_currency, :string
  end
end
