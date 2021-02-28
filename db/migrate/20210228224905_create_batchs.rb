class CreateBatchs < ActiveRecord::Migration[5.2]
  def change
    create_table :batchs do |t|
      t.string :primary
      t.string :secondary
      t.date :mfg
      t.date :exp
      t.timestamps
    end
  end
end
