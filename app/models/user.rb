class User < ApplicationRecord
  has_secure_password

  has_many :issues, dependent: :destroy
  has_many :comments, dependent: :destroy

  enum role: {
    user: 0,
    admin: 1
  }

  validates :email, presence: true, uniqueness: true
end



