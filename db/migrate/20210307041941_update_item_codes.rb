class UpdateItemCodes < ActiveRecord::Migration[5.2]
  def change
    add_column :item_codes, :item_requirement_id, :integer
  end
end
