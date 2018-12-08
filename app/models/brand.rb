class Brand < ApplicationRecord
  has_many :products
  has_many :recoveries

  has_attached_file :logo,
  styles: {
    normal: "120x25>",
  },
  default_url: "/images/:style/missing.png"
  validates_attachment_content_type :logo, content_type: ["image/jpg", "image/jpeg", "image/gif", "image/png"]

  validates_presence_of :name
end