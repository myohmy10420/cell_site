class Product < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :product_images, dependent: :destroy
  accepts_nested_attributes_for :product_images

  belongs_to :brand
  belongs_to :category, optional: true
  has_many :pre_orders

  attr_reader :tele_id
  attr_reader :variant_id
  attr_reader :recovery_id

  validates_presence_of :category_id, on: :update
  validates :name, presence: true, uniqueness: true
  validates_presence_of :slogan, on: :update
  # validates_presence_of :list_price
  validate :check_is_new_limit, on: :update
  validate :check_is_pop_limit, on: :update
  validate :check_is_unlisted_limit, on: :update

  scope :is_new, -> { where(is_new: true) }
  scope :is_pop, -> { where(is_pop: true) }
  scope :is_unlisted, -> { where(is_unlisted: true) }
  scope :except_ids, -> (id) { where.not(id: id) }

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
    if self.is_new && Product.is_new.except_ids(self.id).count >= 9
      errors.add(:is_new, "輪播新產品最多不能超過9筆")
    end

    if self.is_new && self.is_unlisted
      errors.add(:is_new, "不能同時為新產品以及新機發表")
    end
  end

  def check_is_pop_limit
    if self.is_pop && Product.is_pop.except_ids(self.id).count >= 9
      errors.add(:is_pop, "輪播熱門產品最多不能超過9筆")
    end

    if self.is_pop && self.is_unlisted
      errors.add(:is_pop, "不能同時為熱門產品以及新機發表")
    end
  end

  def check_is_unlisted_limit
    if self.is_unlisted && Product.is_unlisted.except_ids(self.id).count >= 9
      errors.add(:is_pop, "輪播新機發表最多不能超過9筆")
    end
  end
end
