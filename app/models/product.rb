class Product < ApplicationRecord
  belongs_to :category

  validates :title, presence: true, length: {minimum: 3}
  validates :price, presence: true
  validates :description, presence: true
  validates :image, presence: true
end
