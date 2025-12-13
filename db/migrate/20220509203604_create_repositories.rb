class CreateRepositories < ActiveRecord::Migration[7.0]
  def change
    create_table :repositories do |t|
      t.integer :repo_type, null: false
      t.text    :repo, null: false
      t.string  :last_release
      t.datetime :last_checked
      t.timestamps
    end
  end
end
