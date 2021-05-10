class SessionsController
    
    
    def create
        session[:current_user_id] = @user.id
    end

    def index
        current_user = User.find_by_id(session[:current_user_id])
    end

end