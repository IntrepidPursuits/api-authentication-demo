class CreateUsers < ActiveRecord::Migration
  def change
    enable_extension 'uuid-ossp'

    create_table :users, id: :uuid do |t|
      t.timestamps null: false

      t.string :email, null: false
      t.string :password_digest, null: false
      t.string :authentication_token, null: false
      t.datetime :authentication_token_expires_at, null: false
    end

    add_index :users, :email, unique: true
    add_index :users, :authentication_token, unique: true
  end
end
