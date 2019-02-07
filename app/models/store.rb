class Store < ApplicationRecord
  has_attached_file :image,
  styles: {
    normal: "240x210>",
  },
  default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: ["image/jpg", "image/jpeg", "image/gif", "image/png"]

  has_many :users, dependent: :nullify

  validates_presence_of :name
  validates_presence_of :image
  validates_presence_of :service_line
  validates_presence_of :address
  validates_presence_of :time
end
