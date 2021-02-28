class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :sku
      t.string :product_description
      t.string :color 
      t.string :company
      t.integer :user_id
    end
  end
end
