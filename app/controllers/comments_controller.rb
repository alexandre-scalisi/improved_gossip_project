class CommentsController < ApplicationController
  before_action :verify_user, only: [:edit, :update, :destroy]
  def index
    puts params
    @gossip = Gossip.find(params[:gossip_id])
  end
  
  def show
    @comment = Comment.find(params[:id])
    
    
  end

  def new
    @gossip = Gossip.find(params[:gossip_id])
    @comment = @gossip.comments.new
  end

  def create
    @comments = Comment.all
    @comment = Comment.new(post_params)
    @comment.user = User.last
    @comment.gossip = Gossip.find(params[:gossip_id])
    if @comment.save
     flash[:success] = "Nouveau comment ajouté avec succés"
     redirect_to gossip_comments_path
    else
      flash[:failure] = "Echec lors de la création du comment, veuillez réessayer"
      render :new
    end
    

    
  end

  def edit
    @gossip = Gossip.find(params[:gossip_id])
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
     @comment.update(post_params)
    redirect_to gossip_comments_path
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to gossip_comments_path
  end

  private

  def post_params
    params.require(:comment).permit(:content)
  end


  def verify_user
    unless sess_id && (Comment.find(params[:id]).user_id == sess_id)
      flash[:failure] = "Ou tu vas petit filou ?"
      redirect_to "/"
    end
  end
end