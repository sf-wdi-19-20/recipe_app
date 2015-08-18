class Recipe < ActiveRecord::Base
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :users, through: :favorites

  validates :name, :instructions,
    presence: true,
    length: {maximum: 255}
end