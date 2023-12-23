# frozen_string_literal: true

class CreateCustomers < ActiveRecord::Migration[7.1]
  def change
    create_table :customers do |t|
      t.string :first_name
      t.string :last_name
      t.integer :gender
      t.string :email, null: false, index: { unique: true }
      t.string :password_digest, null: false
      t.string :phone
      t.integer :age
      t.text :address

      t.timestamps
    end
  end
end
