class SessionsController < ApplicationController
  
  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      puts "User session created with user_id #{user.id}"
      render json: { user_id: user.id, name: user.username}, status: :ok
    else
      render json: { alert: 'Invalid email or password' }, status: :unauthorized
    end
  end

  def destroy
    session[:user_id] = nil
    render json: { notice: 'Logged out successfully!' }, status: :ok
  end
  
end
