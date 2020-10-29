module SessionsHelper
  def current_user
    User.find(session[:user_id])
  end

  def log_in(user)
    session[:user_id] = user.id
  end

  def sess_id
    session[:user_id]
  end
end
