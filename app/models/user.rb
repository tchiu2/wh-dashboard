class User < ApplicationRecord
  before_save :set_defaults

  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true

  def is_admin?
    self.class == Admin
  end

  private

  def set_defaults
    self.type ||= "Customer"
  end
end
