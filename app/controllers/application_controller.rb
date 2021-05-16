class ApplicationController < ActionController::Base
    
    def wrong_page
        render "/wrong_page"
    end

    helper_method :logged_in?, :current_user, :authorized


    def current_user
        @user = User.find_by_id(session[:user_id])
    end

    def authorized?
        @user.errors.add(:authorized, "you must sign in as the corresponding user to modify that")
        render login_path unless logged_in? && @user == current_user
    end

    def logged_in?
        !current_user.nil?
    end 
    def set_user_id
        if @user
            @user_id= @user.id
        end
    end
end
