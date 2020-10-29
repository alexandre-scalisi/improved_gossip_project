class UsersController < ApplicationController
  def show
    @users = User.find(params[:id])
  end

    def index
      @users = User.all
    end
  
    def new 
      @user = User.new
      @cities = City.all
    end
  
    def create
      @user = User.new(params.permit(:first_name, :last_name, :description, :email, :age, :password))
      @user.city = City.find_by(params.permit(:zip_code))
      if @user.save
       flash[:success] = "Nouveau User ajouté avec succés"
       redirect_to user_path(@user.id)
      else
        flash[:failure] = "Echec lors de la création du User, veuillez réessayer"
        render :new
      end
      
  
      
    end
  
    def edit
      @user = User.find(params[:id])
    end
  
    def update
      @user = User.find(params[:id])
       @user.update(post_params)
      redirect_to user_path(@user.id)
    end
  
    def destroy
      @user = User.find(params[:id])
      @user.destroy
      redirect_to "/"
    end
  
    private
  
    def post_params
      params.require(:user).permit(:first_name, :last_name, :description, :email, :age, :password)
    end
  
  
  
  
end
