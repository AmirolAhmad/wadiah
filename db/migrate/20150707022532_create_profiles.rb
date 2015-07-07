class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.string :fname
      t.string :lname
      t.text :address1
      t.text :address2
      t.string :postcode
      t.string :city
      t.string :state
      t.string :country
      t.string :phone_number

      t.timestamps null: false
    end
  end
end
