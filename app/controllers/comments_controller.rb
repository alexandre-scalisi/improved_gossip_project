class CommentsController < ApplicationController
  before_action :verify_user, only: [:edit, :update, :destroy]
  def index
    puts params
    @gossip = Gossip.find(params[:id1])
  end
  
  def show
    @comment = Comment.find(params[:id])
    
    
  end

  def new
    params[:gossip_id] = params[:id1]
    @comment = Comment.new(gossip: Gossip.find(params[:id1]))
  end

  def create
 
    @comments = Comment.all
    @comment = Comment.new(post_params)
    @comment.user = User.last
    @comment.gossip = Gossip.find(params[:id1])
    if @comment.save
     flash[:success] = "Nouveau comment ajouté avec succés"
     redirect_to comments_path
    else
      flash[:failure] = "Echec lors de la création du comment, veuillez réessayer"
      render :new
    end
    

    
  end

  def edit
    @comment = Comment.find(params[:id1])
  end

  def update
    @comment = Comment.find(params[:id])
     @comment.update(post_params)
    redirect_to comments_path
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to comments_path
  end

  private

  def post_params
    params.require(:comment).permit(:content)
  end


  def verify_user
    unless session[:user_id] && (Comment.find(params[:id]).user_id == session[:user_id])
      flash[:failure] = "Ou tu vas petit filou ?"
      redirect_to "/"
    end
  end
end
