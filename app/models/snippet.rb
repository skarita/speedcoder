class Snippet < ApplicationRecord
  belongs_to :user
  has_many :attempts, dependent: :destroy
  validates :name , :description , :language , :body , :word_count , presence: true
  validates :name , uniqueness: true

end
