class Variant < ApplicationRecord
  belongs_to :telecommunication

  validates_presence_of :telecommunication_id
  validates :name, presence: true, uniqueness: true
  validates_presence_of :discount
  validates_presence_of :prepaid
  validates_presence_of :traffic
  validates_presence_of :period
  validates_presence_of :content
end
