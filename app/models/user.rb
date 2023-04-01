class User < ApplicationRecord
    has_secure_password
    has_many :books, dependent: :destroy
    has_many :comments, dependent: :destroy
  
    validates :username, presence: true, uniqueness: true
    validates :email, presence: true, uniqueness: true
    validates :password_digest, presence: true
    validates :password, presence: true, length: { minimum: 6 }
    validates_confirmation_of :password # Add this line
end
