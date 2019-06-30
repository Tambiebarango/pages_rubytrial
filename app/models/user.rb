class User < ApplicationRecord
    has_many :articles, dependent: :destroy
    before_save {self.email= email.downcase}
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :username, presence:true, uniqueness:true, length: { minimum:3, maximum:50}
    validates :email, presence:true, uniqueness:true, format: { with: VALID_EMAIL_REGEX }
    has_secure_password
end
