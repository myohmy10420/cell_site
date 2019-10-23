class Store < ApplicationRecord
  has_attached_file :image,
  styles: {
    medium: "250x250#",
  },
  default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: ["image/jpg", "image/jpeg", "image/gif", "image/png"]

  has_many :users, dependent: :nullify

  validates :name, presence: true, uniqueness: true
  validates_presence_of :service_line
  validates_presence_of :address
  validates_presence_of :google_map_url
  validates_presence_of :time

  def editable?(user)
    user.in?(users)
  end
end
