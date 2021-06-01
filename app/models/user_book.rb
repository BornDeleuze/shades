class UserBook < ApplicationRecord
    belongs_to :user
    belongs_to :book
    validates :book_id, :user_id, presence: true

    def self.search(q)
        UserBook.all.select do |book|
            book.book.author.include?(q)
        end
    end
end
