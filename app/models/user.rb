class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :store

  validates :phone, presence: true, uniqueness: true
  validates :sex, presence: true

  after_create :assign_default_role

  attr_reader :accept_terms

  def email_required?
    false
  end

  def assign_default_role
    self.add_role(:normal) if self.roles.blank?
  end
end
