class User < ApplicationRecord
  has_secure_password
  has_many :snippets
  has_many :attempts

  validates :name, :email, :username, presence: true
  validates :email, :username, uniqueness: true
end
