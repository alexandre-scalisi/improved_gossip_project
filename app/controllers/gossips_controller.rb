class GossipsController < ApplicationController
  before_action :authenticate_user, only: [:new,:create,:like]
  before_action :verify_user, only: [:edit, :update, :destroy]
  before_action :get_gossip, except: [:index, :new, :create]
  def index
    @users = User.all
  end
  
  def show
    unless sess_id then return end
    @is_user = @gossip.user == current_user
    @already_liked = @gossip.likers.include?(current_user)
  end

  def new
    @gossip = Gossip.new
  end

  def create
    @gossip = Gossip.new(params.permit(:title, :content))
    @gossip.user = current_user
    if @gossip.save

     flash[:success] = "Nouveau gossip ajouté avec succés"
     redirect_to gossip_path(@gossip.id)
    else
      flash[:failure] = "Echec lors de la création du gossip, veuillez réessayer"
      render :new
    end
    

    
  end

  def edit
  end

  def update
     @gossip.update(post_params)
    redirect_to gossip_path(@gossip.id)
  end

  def destroy
    @gossip.destroy
    redirect_to "/"
  end

  def like
    like = Like.find_by(user_id:sess_id,gossip_id: @gossip.id )
    if like
      like.destroy
    else
      Like.create(user_id: sess_id, gossip_id: @gossip.id)
    end
    redirect_to gossip_path(@gossip.id)
  end
  

  private

  def post_params
    params.require(:gossip).permit(:title, :content)
  end
  

  def authenticate_user
    unless sess_id
      flash[:failure] = "Please log in."
      redirect_to new_session_path
    end
  end

  def verify_user
    unless sess_id && (Gossip.find(params[:id]).user_id == sess_id)
      flash[:failure] = "Ou tu vas petit filou ?"
      redirect_to "/"
    end
  end

  def get_gossip
    @gossip = Gossip.find(params[:id])
  end

  
end
