class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  devise :database_authenticatable, :registerable, :recoverable, :validatable, :jwt_authenticatable, jwt_revocation_strategy: self
  
  has_many :posts, dependent: :destroy
  validates :email, presence: true


  def self.ransackable_associations(auth_object = nil)
    ["posts"]
  end


  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "email", "encrypted_password", "id", "jti", "name", "remember_created_at", "reset_password_sent_at", "reset_password_token", "updated_at"]
  end
end
