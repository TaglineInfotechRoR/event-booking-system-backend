# frozen_string_literal: true

class CreateCustomers < ActiveRecord::Migration[7.1]
  def change
    create_table :customers do |t|
      t.string :first_name
      t.string :last_name
      t.integer :age
      t.integer :gender
      t.string :phone
      t.string :email, null: false, index: { unique: true }
      t.string :password_digest, null: false
      t.string :address

      t.timestamps
    end
  end
end
