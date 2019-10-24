class PreOrder < ApplicationRecord
  belongs_to :user
  belongs_to :store
  belongs_to :product

  validates_presence_of :product_name
end
