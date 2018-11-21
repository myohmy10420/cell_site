class Telecommunication < ApplicationRecord
  has_many :variants

  validates_presence_of :name
end
