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
        if logged_in
            @user_book = UserBook.new()
        else
            redirect_to login_path
    end

    def create    
    end

    def edit
        if logged_in
        else
            redirect_to login_path
    end

    def update
#build out update
    end

    private
        def set_book
            @user_book = UserBook.find_by_id(params[:id])
        end
        def set_user
            @user = User.find_by_id(params[:user_id])
        end
       
end