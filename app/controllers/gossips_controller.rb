class GossipsController < ApplicationController
  before_action :authenticate_user, only: [:new,:create,:like]
  before_action :verify_user, only: [:edit, :update, :destroy]
  def index
    @users = User.all
  end
  
  def show
    @gossip = Gossip.find(params[:id])
    unless session[:user_id] then return end
    @is_user = @gossip.user == User.find(session[:user_id])
    @already_liked = @gossip.likers.include?(User.find(session[:user_id]))
  end

  def new
    @gossip = Gossip.new
  end

  def create
    @gossip = Gossip.new(params.permit(:title, :content))
    @gossip.user = User.find(session[:user_id])
    if @gossip.save

     flash[:success] = "Nouveau gossip ajouté avec succés"
     redirect_to gossip_path(@gossip.id)
    else
      flash[:failure] = "Echec lors de la création du gossip, veuillez réessayer"
      render :new
    end
    

    
  end

  def edit
    @gossip = Gossip.find(params[:id])
  end

  def update
    @gossip = Gossip.find(params[:id])
     @gossip.update(post_params)
    redirect_to gossip_path(@gossip.id)
  end

  def destroy
    @gossip = Gossip.find(params[:id])
    @gossip.destroy
    redirect_to "/"
  end

  def like
    @gossip = Gossip.find(params[:id])
    like = Like.find_by(user_id:session[:user_id],gossip_id: @gossip.id )
    if like
      like.destroy
    else
      Like.create(user_id: session[:user_id], gossip_id: @gossip.id)
    end
    redirect_to gossip_path(@gossip.id)
  end
  

  private

  def post_params
    params.require(:gossip).permit(:title, :content)
  end
  

  def authenticate_user
    unless session[:user_id]
      flash[:failure] = "Please log in."
      redirect_to new_session_path
    end
  end

  def verify_user
    unless session[:user_id] && (Gossip.find(params[:id]).user_id == session[:user_id])
      flash[:failure] = "Ou tu vas petit filou ?"
      redirect_to "/"
    end
  end

  
end
