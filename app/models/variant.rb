class Variant < ApplicationRecord
  belongs_to :telecommunication

  validates_presence_of :telecommunication_id
  validates_presence_of :name
  validates_presence_of :discount
  validates_presence_of :prepaid
  validates_presence_of :traffic
  validates_presence_of :period
  validates_presence_of :content
end
