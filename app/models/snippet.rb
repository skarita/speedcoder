class Snippet < ApplicationRecord
  belongs_to :user
  has_many :attempts, dependent: :destroy
  validates :name , :description , :language , :body , :word_count , presence: true
  validates :name , uniqueness: true

  def users_played
    @myId = self.id
    @attempts = Attempt.where('snippet_id' => @myId).order('score DESC').to_a.uniq {|attempt| attempt[:user_id] }.length
  end
end
