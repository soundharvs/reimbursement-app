class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      if current_user.role == 1
        redirect_to admin_index_bills_path, notice: "Logged in successfully."
      else
        redirect_to bills_path, notice: "Logged in successfully."
      end
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
