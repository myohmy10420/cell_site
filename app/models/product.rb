class Product < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :slogan
  validates_presence_of :content
  validate :check_is_new_limit
  validate :check_is_pop_limit

  has_attached_file :image,
    styles: {
      large: "800x400>",
      small: "240x200>"
    },
    default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: ["image/jpg", "image/jpeg", "image/gif", "image/png"]

  belongs_to :brand

  private

  def check_is_new_limit
    if Product.where(is_new: true).size >= 8 && self.is_new
      errors.add(:is_new, "輪播新產品最多不能超過8筆")
    end
  end

  def check_is_pop_limit
    if Product.where(is_pop: true).size >= 8 && self.is_pop
      errors.add(:is_pop, "輪播熱門產品最多不能超過8筆")
    end
  end
end
