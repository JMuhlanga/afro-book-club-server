class UsersController < ApplicationController
    before_action :require_login, only: [:update, :destroy]

    def index
        @users = User.select(:id, :username, :email)
    end

    def show
        @user = User.find(params[:id])
    end

    def create
      @user = User.new(user_params)
      if @user.password == params[:password_confirmation] && @user.save
        session[:user_id] = @user.id
        redirect_to root_path, notice: 'Account created successfully!'
      else
        @user.errors.add(:password_confirmation, "doesn't match Password") unless @user.password == params[:password_confirmation]
        render :new
      end
    end

    def destroy
        @user = User.find(params[:id])
        @user.destroy
        session[:user_id] = nil if current_user == @user
        redirect_to root_path, notice: 'Account deleted successfully!'
    end
  
    private
  
    def user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end

    def require_login
        unless session[:user_id]
          redirect_to login_path, alert: 'You must be logged in to perform this action!'
        end
    end
    
end
  
