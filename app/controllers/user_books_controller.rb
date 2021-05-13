class UserBooksController < ApplicationController
   
    before_action :find_book, only: [:show, :edit, :update, :destroy]

    def index
        if params[:user_id]
            set_user
            @user_books = @user.user_books
        else
            @user_books = UserBook.all
    end
    def show

    end
    def new

    end
    def create
        
    end
    def edit

    end
    def update

    end

    private
        def set_book
            @user_book = UserBook.find_by_id(params[:id])
        end
        def set_user
            @user = User.find_by_id(params[:user_id])
        end
end