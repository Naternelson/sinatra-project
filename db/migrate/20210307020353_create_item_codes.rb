class CreateItemCodes < ActiveRecord::Migration[5.2]
  def change
    create_table :item_codes do |t|
      t.string :code
      t.integer :item_id 
    end
  end
end
