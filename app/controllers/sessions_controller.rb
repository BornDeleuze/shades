class SessionsController < ApplicationController
    
    def new
        @user = User.new
    end
    def create
        @user = User.find_by(email: params[:email])
            session[:current_user_id] = @user.id

            if  @user && @user.authenticate(params[:password])
                session[:user_id] = @user.id

                redirect_to user_path(@user)
            else
                redirect_to login_path
            end 
    end

    def index
        current_user = User.find_by_id(session[:current_user_id])
    end

    def login
        binding.pry
    end

    def destroy
        session.clear
        redirect_to login_path
    end
end