class UsersController < ApplicationController


    before_action :find_user, only: [:show, :edit, :update, :destroy]

    def show
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
        if @user.update
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
        params.require(:user).permit(:password, :email, :name)
    end

end
