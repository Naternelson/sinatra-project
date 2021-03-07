class ItemCode < ActiveRecord::Base 
    belongs_to :item
    belongs_to :item_requirement
end