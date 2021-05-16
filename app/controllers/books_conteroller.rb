class BooksController < ActionController

    def index
        @books = Book.all
    end
    def show
        @book = Book.find_by_id(params(:id))
    end
end