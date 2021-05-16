class BooksController < ActionController

    def index
        @books = Book.all
    end
end