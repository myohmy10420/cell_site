class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :store

  validates_presence_of :phone

  after_create :assign_default_role

  def email_required?
    false
  end

  def assign_default_role
    self.add_role(:normal) if self.roles.blank?
  end
end
