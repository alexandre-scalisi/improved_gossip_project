class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    email = params.permit(:email)
    user = User.find_by(email)
    if user && user.authenticate(params.permit(:password)[:password])
      log_in(user)
      redirect_to welcome_path(current_user.first_name)
    else 
      flash[:failure] = "Echec lors de la l'authentification, veuillez réessayer"
      redirect_to new_session_path
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to '/'
  end
end
