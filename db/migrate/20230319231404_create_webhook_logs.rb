class CreateWebhookLogs < ActiveRecord::Migration[7.0]
  def change
    create_table :webhook_logs do |t|
      t.text  :data
      t.timestamps
    end
  end
end
