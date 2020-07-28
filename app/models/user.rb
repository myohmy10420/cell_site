class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  belongs_to :store
  has_many :pre_orders

  validates :email, presence: true, uniqueness: true
  validates_presence_of :sex, :name, :phone

  after_create :assign_default_role

  attr_reader :accept_terms

  def assign_default_role
    self.add_role(:normal) if self.roles.blank?
  end
end
