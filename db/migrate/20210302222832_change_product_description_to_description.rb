class ChangeProductDescriptionToDescription < ActiveRecord::Migration[5.2]
  def change
    rename_column :products, :product_description, :description
  end
end
