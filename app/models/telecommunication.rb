class Telecommunication < ApplicationRecord
  has_many :variants, dependent: :delete_all

  has_attached_file :logo,
  styles: {
    medium: "140x40#",
  },
  default_url: "/images/:style/missing.png"
  validates_attachment_content_type :logo, content_type: ["image/jpg", "image/jpeg", "image/gif", "image/png"]

  validates :name, presence: true, uniqueness: true
end
