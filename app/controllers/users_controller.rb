class UsersController < ApplicationController

    before_action :find_user, :set_user_id, only: [:show, :edit, :update, :destroy, :index]
    
    def index
        current_user
        @users = User.all
    end
    
    def show
        @rare_books = Book.rare

        if logged_in?
        else
            redirect_to login_path
        end
    end

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)

        if @user.save
            session[:user_id] = @user.id
            redirect_to @user
        else
            render :new
        end
    end

    def edit
    end

    def update
        if @user.update(user_params)
            redirect_to @user
        else
            render :edit
        end
    end

    private

    def find_user
        @user = User.find_by_id(params[:id])
    end
    def user_params
        params.require(:user).permit(:password, :email, :username)
    end

end
