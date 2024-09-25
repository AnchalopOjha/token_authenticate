class Post < ApplicationRecord
  belongs_to :user
  has_many_attached :images

  validates :title, :content, presence: true

  def self.ransackable_associations(auth_object = nil)
    ["user"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["content", "created_at", "id", "title", "updated_at", "user_id"]
  end
end
