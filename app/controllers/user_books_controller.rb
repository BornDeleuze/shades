class UserBooksController < ApplicationController
   
    before_action :set_books, only: [:show, :edit, :update, :destroy]

    def index
        current_user
        if params[:user_id]
            @user_books = @user.user_books
        else
            @user_books = UserBook.all
        end
    end

    def show
        current_user
        set_user_id
    end
    
    def new
        if logged_in?
            @user_book = UserBook.new()
        else
            redirect_to login_path
        end
    end

    def create
         binding.pry
        if logged_in?
                current_user
                if book = Book.find_by(author: params[:user_book][:book][:author],
                    title: params[:user_book][:book][:title])
                    @user_book = UserBook.new(condition: params[:user_book][:condition])
                    @user_book.book= book
                    @user_book.user= current_user
                else
                    book = Book.create(author: params[:user_book][:book][:author],
                    title: params[:user_book][:book][:title])
                    @user_book = UserBook.new(condition: params[:user_book][:condition])
                    @user_book.book= book
                    @user_book.user= current_user
                end
                binding.pry
                if @user_book.save
                    redirect_to user_user_books_path(@user, @userbook)
                else
                    render :new
                end
                
        else
            redirect_to login_path     
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
            params.require(:user_book).permit(:title, :author, :genre, :condition)
            
        end
        def set_books
            @user_book = UserBook.find_by_id(params[:id])
        end       
end