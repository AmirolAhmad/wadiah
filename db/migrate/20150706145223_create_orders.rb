class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.string :order_number
      t.integer :quantity
      t.decimal :total_price, :precision => 8, :scale => 2
      t.string :status

      t.timestamps null: false
    end
  end
end
