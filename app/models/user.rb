class User < ApplicationRecord
    has_many :reviews
    has_many :songs,through: :reviews
    has_secure_password
    
    validates :username, presence: true, uniqueness: true 
    validates :email, presence: true
end
