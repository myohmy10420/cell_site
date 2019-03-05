class Recovery < ApplicationRecord
  belongs_to :brand

  validates_presence_of :brand_id
  validates :name, presence: true, uniqueness: true
  validates_presence_of :max_price
  validates_presence_of :min_price
end
