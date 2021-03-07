class ItemRequirement < ActiveRecord::Base
    belongs_to :product
    has_many :item_codes
end