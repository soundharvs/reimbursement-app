class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: "Logged in successfully."
    else
      flash.now[:alert] = "Invalid email or password."
      render :new
    end
  end

  def destroy
    log_out
    redirect_to login_path, notice: "Logged out!"
  end

  private

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
end
