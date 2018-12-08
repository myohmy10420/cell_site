class Store < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :service_line
  validates_presence_of :address
  validates_presence_of :time
end
