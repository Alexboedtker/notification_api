class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.datetime :date
      t.string :title
      t.text :description
      t.references :admin, null: false
      t.references :client, null: false

      t.timestamps
    end
    add_foreign_key :notifications, :users, column: :admin_id
    add_foreign_key :notifications, :users, column: :client_id
  end
end
