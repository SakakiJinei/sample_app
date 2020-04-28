class Chat < ApplicationRecord
  validates :content,  {presence: true}
end
