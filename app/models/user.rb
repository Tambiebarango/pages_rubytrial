class User < ApplicationRecord
    has_many :articles
    VALID_EMAIL_REGEX = "/\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i"
    validates :username, presence:true, uniqueness:true, length: { minimum:3, maximum:50}
    validates :email, presence:true, uniqueness:true
end
