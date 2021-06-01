class UserBooksController < ApplicationController
   
    before_action :set_book, only: [:show, :edit, :update, :destroy]
    def index
        current_user
        if params[:user_id]
            friend = User.find_by_id(params[:user_id])
            @user_books = friend.user_books
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
            if params[:format]
                @user_book = UserBook.find_by_id(params[:format])
                @user_book.condition = nil
                flash.notice = "Please enter the condition of your book!"
            else
                @user_book = UserBook.new()
                @user_book.book = Book.new()
            end
        else
            redirect_to login_path
        end
    end

    def create
        @user_book = UserBook.new()
        @user_book.book = Book.new()
        if Book.new(author: params[:user_book][:book][:author],
            title: params[:user_book][:book][:title]).valid?
            if logged_in?
                    current_user
                    if book = Book.find_by(author: params[:user_book][:book][:author],
                        title: params[:user_book][:book][:title],
                        genre: params[:user_book][:book][:genre],
                        year: params[:user_book][:book][:year],
                        publisher: params[:user_book][:book][:publisher])
                        @user_book = UserBook.new(condition: params[:user_book][:condition])
                        @user_book.user= current_user
                    else
                        book = Book.new(author: params[:user_book][:book][:author],
                        title: params[:user_book][:book][:title],
                        genre: params[:user_book][:book][:genre],
                        year: params[:user_book][:book][:year],
                        publisher: params[:user_book][:book][:publisher],
                        rare: params[:user_book][:book][:rare])
                        @user_book = UserBook.new(condition: params[:user_book][:condition])
                        @user_book.user= current_user
                    end
                    if book.save 
                        @user_book.book = book
                        if @user_book.save
                            redirect_to user_user_books_path(@user, @userbook)
                            else
                                render :new
                        end
                    else
                        render :new
                    end
            else
                redirect_to login_path     
            end
        else
            @user_book.errors.add(:author_and_title, "must be valid") 
            render :new
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
            @user_book.book.year = params[:user_book][:book][:year]
            @user_book.book.publisher = params[:user_book][:book][:publisher]
            @user_book.book.rare = params[:user_book][:book][:rare]
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
        def user_book_params
            params.require(:user_book).permit(:title, :author, :genre, :year, :publisher, :rare, :condition)
        end
        def set_book
            @user_book = UserBook.find_by_id(params[:id])
        end       
end