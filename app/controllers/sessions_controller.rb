class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    email = params.permit(:email)
    user = User.find_by(email)
    if user && user.authenticate(params.permit(:password)[:password])
    log_in(user)
    redirect_to "/"
    else render :new
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to "/"
  end
end
