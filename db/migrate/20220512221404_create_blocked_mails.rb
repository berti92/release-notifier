class CreateBlockedMails < ActiveRecord::Migration[7.0]
  def change
    create_table :blocked_mails do |t|
      t.string  :mail_address, null: false
      t.timestamps
    end
  end
end
