class User < ApplicationRecord
  attr_accessor :remember_token, :activation_token
  before_save {self.email = email.downcase}
  before_save   :downcase_email
  before_create :create_activation_digest
  validates :name, presence: true
  validates :email, uniqueness: true
  has_many :posts, dependent: :destroy
  has_secure_password

  def feed
    Post.where "user_id = ?", id
  end

  class << self
    def new_token
      SecureRandom.urlsafe_base64
    end

    def digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
        BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end
  end

  def remember
    self.remember_token = User.new_token
    update_attribute :remember_digest, User.digest(remember_token)
  end

  def authenticated? remember_token
    BCrypt::Password.new(remember_digest).is_password? remember_token
  end
  
  def forget
    update_attribute :remember_digest, nil
  end

  private

  def downcase_email
    self.email = email.downcase
  end

  def create_activation_digest
    self.activation_token  = User.new_token
    self.activation_digest = User.digest(activation_token)
  end
end
