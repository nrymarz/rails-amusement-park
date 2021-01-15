class SessionsController < ApplicationController
    def new
        @user = User.new
        render 'users/signin'
    end

    def create
        user = User.find_by(name: user_params[:name])
        if user && user.authenticate(user_params[:password])
            session[:user_id] = user.id 
            redirect_to user_path(user)
        else
            render '/users/signin'
        end
    end

    def destroy
        session.delete :user_id
        redirect_to root_path
    end

    private 
    def user_params
        params.require(:user).permit(:name,:password)
    end
end