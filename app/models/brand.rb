class Brand < ApplicationRecord
  has_many :products,   dependent: :delete_all
  has_many :recoveries, dependent: :delete_all
  has_many :categories, dependent: :delete_all

  has_attached_file :logo,
  styles: {
    medium: "140x40#",
  },
  default_url: "/images/:style/missing.png"
  validates_attachment_content_type :logo, content_type: ["image/jpg", "image/jpeg", "image/gif", "image/png"]

  # scope :has_products, -> { joins(:products).uniq }

  # scope :has_categories, -> { left_outer_joins(:products).distinct.where('products.id IS NULL') }

  scope :has_categories, -> { joins(:categories).distinct }

  validates :name, presence: true, uniqueness: true

  before_create :init_sort

  def init_sort
    self.sort = Brand.all.size + 1
  end
end
