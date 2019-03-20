class Product < ApplicationRecord
  has_many :product_images, dependent: :destroy
  accepts_nested_attributes_for :product_images

  belongs_to :brand
  has_many :pre_orders

  attr_reader :tele_id
  attr_reader :variant_id
  attr_reader :recovery_id

  validates :name, presence: true, uniqueness: true
  validates_presence_of :slogan
  validates_presence_of :content
  validates_presence_of :list_price
  validate :check_is_new_limit
  validate :check_is_pop_limit

  def has_images?
    self.product_images.exists?
  end

  def images
    self.product_images
  end

  def first_image
    self.product_images.first.image
  end

  private

  def check_is_new_limit
    if self.is_new && Product.where(is_new: true).size >= 8
      errors.add(:is_new, "輪播新產品最多不能超過8筆")
    end
  end

  def check_is_pop_limit
    if self.is_pop && Product.where(is_pop: true).size >= 8
      errors.add(:is_pop, "輪播熱門產品最多不能超過8筆")
    end
  end
end
