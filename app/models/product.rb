class Product < ActiveRecord::Base
    belongs_to :user
    has_many :item_requirements
    has_many :orders
end