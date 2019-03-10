class SideBarAd < ApplicationRecord
  has_attached_file :image,
    styles: {
      medium: "225x65#"
    },
    default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: ["image/jpg", "image/jpeg", "image/gif", "image/png"]

  validates_presence_of :image
end
