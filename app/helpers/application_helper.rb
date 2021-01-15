module ApplicationHelper
    def logged_in?
        !!session[:user_id]
    end
    
    def current_user
        User.find_by_id(session[:user_id])
    end

    def logged_in_as_admin?
        logged_in? && current_user.admin
    end
end
