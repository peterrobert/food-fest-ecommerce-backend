class Category < ApplicationRecord
    has_many :products, class_name: "Product", foreign_key: "category_id"
    validates :name, presence: true, length: {minimum: 3}
end
