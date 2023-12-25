# frozen_string_literal: true

class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.references :event_organizer, null: false, foreign_key: true
      t.string :name
      t.date :date
      t.string :venue, null: false

      t.timestamps
    end
  end
end
