class User < ApplicationRecord
  has_secure_password

  has_many :snippets, dependent: :destroy
  has_many :attempts, dependent: :destroy

  # Validation constraints
  validates :name, :email, :username, presence: true
  validates :email, uniqueness: true

  validates :username, uniqueness: true, length: {
    in: 4..400,
    },
    format: {
      without: /[^a-z0-9]/i,
      message: "no special characters or spacing"
    },
    exclusion: {
      :in => %w(login signup settings add api snippets search browse archive),
      message: "has already been taken"
    }
  validates :email,
    format: {
      with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
    }

end
