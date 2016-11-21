class User < ApplicationRecord
  has_secure_password
  has_many :snippets
  has_many :attempts
end
