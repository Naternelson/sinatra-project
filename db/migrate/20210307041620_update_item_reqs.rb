class UpdateItemReqs < ActiveRecord::Migration[5.2]
  def change
    rename_column :item_requirements, :required, :unique
  end
end
