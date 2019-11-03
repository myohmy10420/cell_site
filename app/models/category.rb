class Category < ApplicationRecord
  belongs_to :brand
  has_many :products

  validates :name, presence: true,  uniqueness: { scope: :brand }
end
