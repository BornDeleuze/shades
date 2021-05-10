class Book < ApplicationRecord
    has_many :user_books
    has_many :users, though: user_books
    
    validates :title, presence: true, uniqueness: true

    validates :author, presence: true
end
