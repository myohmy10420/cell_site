class Product < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :slogan
  validates_presence_of :content
end
