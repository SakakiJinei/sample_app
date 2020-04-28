class Post < ApplicationRecord
  validates :title,    {presence: true, uniqueness: true}
  validates :category, {presence: true}
  validates :price,    {presence: true, numericality: true}
  validates :content,  {presence: true}
  validates :user_id,  {presence: true}
  
  def user
    return User.find_by(id: self.user_id)
  end
  
  def self.search(search) 
    if search 
      Post.where(['title LIKE ?', "%#{search}%"])
    else
      Post.all 
    end
  end  
  
  def self.category(category) 
    if category 
      Post.where(['category LIKE ?', "%#{category}%"])
    else
      Post.all 
    end
  end
end

