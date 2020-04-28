class User < ApplicationRecord
  
  has_secure_password

  before_save { email.downcase! }
  validates :name,     {presence: true}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email,    {presence: true, 
                        uniqueness: { case_sensitive: false },
                        format: { with: VALID_EMAIL_REGEX }
                        }
  validates :password,     {presence: true, length: {minimum: 5}}                      
                        

  
  def posts
    return Post.where(user_id: self.id)
  end
end
