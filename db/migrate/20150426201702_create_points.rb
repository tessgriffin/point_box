class CreatePoints < ActiveRecord::Migration
  def change
    create_table :points do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.boolean :redeemed, null: false, default: false

      t.timestamps null: false
    end
  end
end
