class UserBooksController < ApplicationController
   
    before_action :set_book, only: [:show, :edit, :update, :destroy]

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
            @user_book.book = Book.new()
        else
            redirect_to login_path
        end
    end

    def create
        if logged_in?
                current_user
                if book = Book.find_by(author: params[:user_book][:book][:author],
                    title: params[:user_book][:book][:title],
                    genre: params[:user_book][:book][:genre])
                    @user_book = UserBook.new(condition: params[:user_book][:condition])
                    @user_book.user= current_user
                else
                    book = Book.new(author: params[:user_book][:book][:author],
                    title: params[:user_book][:book][:title],
                    genre: params[:user_book][:book][:genre])
                    @user_book = UserBook.new(condition: params[:user_book][:condition])
                    @user_book.user= current_user
                end
                if book.save && @user_book.book = book && @user_book.save
                    redirect_to user_user_books_path(@user, @userbook)
                else
                    render :new
                end
        else
            redirect_to login_path     
        end
    end

    def edit
    end

    def update
        if logged_in? && authorized?
            current_user
            @user_book.condition = params[:user_book][:condition]
            @user_book.book.title = params[:user_book][:book][:title]
            @user_book.book.author = params[:user_book][:book][:author]
            @user_book.book.genre = params[:user_book][:book][:genre]
            if  @user_book.save
                redirect_to user_user_books_path(@user, @userbook)
            else
                redirect_to edit_user_user_book_path(@user, @user_book)
            end
        end
    end

    def destroy
        if logged_in? && authorized?
            @user_book.destroy
            redirect_to user_user_books_path(@user)
        else
            redirect_to login_path
        end
    end

    private
        def book_params
            params.require(:user_book).permit(:title, :author, :genre, :condition)
        end
        def set_book
            @user_book = UserBook.find_by_id(params[:id])
        end       
end