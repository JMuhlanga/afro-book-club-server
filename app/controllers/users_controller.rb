class UsersController < ApplicationController
  before_action :require_login, only: [:update, :destroy]

  def index
    @users = User.select(:id, :username, :email)
    render json: @users
  end

  def show
    @user = User.find(params[:id])
    render json: @user
  end

  def create
    user = User.new(user_params)
  
    if user.save
      session[:user_id] = user.id
      render json: { message: 'Account created successfully!' }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end
  

  def update
    @user = User.find(params[:id])
  
    if @user.update(user_params)
      render json: { message: 'User was successfully updated.' }, status: :ok
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    session[:user_id] = nil if current_user == @user
    render json: { message: 'Account deleted successfully!' }, status: :ok
  end
  

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :repeatPassword)
  end
  
   

  def require_login
    unless session[:user_id]
      redirect_to login_path, alert: 'You must be logged in to perform this action!'
    end
  end
end
