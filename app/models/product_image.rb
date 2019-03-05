class ProductImage < ApplicationRecord
  belongs_to :product

  has_attached_file :image,
    styles: {
      medium: "300x300#"
    },
    default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: ["image/jpg", "image/jpeg", "image/gif", "image/png"]

  do_not_validate_attachment_file_type :image
end
