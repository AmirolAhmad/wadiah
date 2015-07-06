class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :order, index: true, foreign_key: true
      t.string :payment_method
      t.string :payment_date
      t.string :payment_time
      t.string :reference_number
      t.decimal :total_payment, :precision => 8, :scale => 2
      t.string :attachment
      t.string :receipt_number

      t.timestamps null: false
    end
  end
end
