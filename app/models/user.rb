class User < ApplicationRecord
  before_save {self.email = email.downcase}
  validates :name, presence: true
  validates :email, uniqueness: true
  has_secure_password
end
