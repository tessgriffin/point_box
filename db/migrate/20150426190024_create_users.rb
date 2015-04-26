class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email, index: true, unique: true
      t.string :encrypted_password
    end
  end
end
