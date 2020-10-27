class GossipsController < ApplicationController
  def index
    @users = User.all
  end
  
  def show
    @gossip = Gossip.find(params[:id])
  end

  def new
    @gossip = Gossip.new
  end

  def create
    @gossip = Gossip.new(params.permit(:title, :content))
    @gossip.user = User.last
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

  private

  def post_params
    params.require(:gossip).permit(:title, :content)
  end


end
