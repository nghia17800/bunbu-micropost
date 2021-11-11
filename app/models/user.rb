class User < ApplicationRecord
  attr_accessor :remember_token, :activation_token
  before_save {self.email = email.downcase}
  before_save   :downcase_email
  before_create :create_activation_digest
  validates :name, presence: true
  validates :email, uniqueness: true
  has_many :posts, dependent: :destroy
  has_many :active_relationships, class_name: Relationship.name, foreign_key: :follower_id, dependent: :destroy
  has_many :passive_relationships, class_name: Relationship.name, foreign_key: :followed_id, dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :providers
  has_secure_password

  def feed
    Post.where("user_id IN (?) OR user_id = ?", following_ids, id)
  end

  def follow(other_user)
    following << other_user
  end

  def unfollow(other_user)
    following.delete(other_user)
  end

  def following?(other_user)
    following.include?(other_user)
  end

  def self.create_from_omniauth(auth)
    user = User.find_by(email: auth["info"]["email"])
    if user.present?
      provider = user.providers.find_by(name: auth["provider"])
      if provider.present?
        provider.update(uid: auth["uid"])
      else
        Provider.create(name: auth["provider"], uid: auth["uid"], user_id: user.id)
      end
    else
      user = User.create(
        email: auth["info"]["email"],
        name: auth["info"]["name"],
        password: SecureRandom.hex(16)
      )
      Provider.create(name: auth["provider"], uid: auth["uid"], user_id: user.id)
    end
    user
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
