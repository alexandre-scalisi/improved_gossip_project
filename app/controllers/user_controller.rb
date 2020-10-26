class UserController < ApplicationController
  def info
    @user = User.find_by(first_name: params[:name])
  end
end
