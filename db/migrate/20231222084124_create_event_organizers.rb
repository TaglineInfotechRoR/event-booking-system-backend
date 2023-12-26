# frozen_string_literal: true

class CreateEventOrganizers < ActiveRecord::Migration[7.1]
  def change
    create_table :event_organizers do |t|
      t.string :first_name
      t.string :last_name
      t.string :password_digest, null: false
      t.string :email, null: false, index: { unique: true }
      t.integer :gender
      t.string :phone

      t.timestamps
    end
  end
end
