class Book < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :ratings, dependent: :destroy

end
