class UserBooksController < ApplicationController
   
    before_action :set_book, only: [:show, :edit, :update, :destroy]

    def index
        binding.pry
        if params[:user_id]
            set_user
            @user_books = @user.user_books
        else
            @user_books = UserBook.all
        end
    end

    def show
    end
    
    def new
        if logged_in? && authorized?
            @user_book = UserBook.new()
        else
            binding.pry
            redirect_to login_path
        end
    end

    def create    
        binding.pry
        if params[:user_id]
            current_user
            @user_book = @user.user_books.build(book_params)
        else
            redirect_to login_path
        end

        if @user_book.save
            redirect_to user_user_books_path(@user, @userbook)
        else
            render :new
        end
    end

    def edit
        if logged_in? && authorized?
        else
            redirect_to login_path
        end
    end

    def update
#build out update
    end

    private
        def book_params
            params.require(:user_book).permit(:user_book_title, :user_book_author, :user_book_genre, :user_book_condition)
            
        end
        def set_book
            @user_book = UserBook.find_by_id(params[:id])
        end
        def set_user
            @user = User.find_by_id(params[:user_id])
        end
       
end