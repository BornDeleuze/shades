class SessionsController < ApplicationController
    
    def new
        if current_user
            redirect_to user_path(current_user)
        else
        @user = User.new
        end
    end
    def create
        if User.find_by(email: params[:email])
            @user = User.find_by(email: params[:email])
            if  @user && @user.authenticate(params[:password])
                session[:user_id] = @user.id
                redirect_to user_path(@user)
            else
                redirect_to '/login', notice: "Email/Password not found"
            end 
        else
            redirect_to '/login', notice: "Email/Password not found"
        end

    end

    def index
        current_user = User.find_by_id(session[:current_user_id])
    end

    def login
    end

    def destroy
        session.clear
        redirect_to login_path
    end

    def google
        @user = User.find_or_create_by(email: auth["info"]["email"], username: auth["info"]["name"]) do |user|
            user.password = SecureRandom.hex(13)
        end
        if @user && @user.id
            session[:user_id] = @user.id
            redirect_to user_path(@user)
        else
            render :new
        end
    end

    private

    def auth
        request.env['omniauth.auth']
    end
end