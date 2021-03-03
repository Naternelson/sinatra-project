class CreateItemRequirements < ActiveRecord::Migration[5.2]
  def change
    create_table :item_requirements do |t|
      t.string :name
      t.integer :length
      t.string :description 
      t.boolean :required
      t.boolean :length_required
      t.integer :product_id
    end
  end
end
