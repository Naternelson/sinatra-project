class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer :order_num
      t.integer :amount
      t.datetime :recieved_on
      t.datetime :due_by
      t.string :status
      t.integer :product_id
    end
  end
end
