class Favorite < ApplicationRecord
  belongs_to :user

  validates :recipe_link, presence: true
  validates :recipe_title, presence: true
  validates :country, presence: true
  validates :user_id, presence: true
  
end