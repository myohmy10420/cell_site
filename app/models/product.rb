class Product < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :slogan
  validates_presence_of :content

  has_attached_file :avatar,
    styles: {
      large: "800x400>",
      small: "240x200>"
    },
    default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: ["image/jpg", "image/jpeg", "image/gif", "image/png"]
end
