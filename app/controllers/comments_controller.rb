class CommentsController < ApplicationController
  before_action :verify_user, only: %i[edit update destroy]
  before_action :get_comment, except: %i[index new create]
  before_action :get_gossip, only: %i[index new edit]
 
  def index
  end

  def show
  end

  def new
    @comment = @gossip.comments.new
  end

  def create
    @comment = Comment.new(post_params)
    @comment.user = current_user
    @comment.gossip = get_gossip
    if @comment.save
      flash[:success] = 'Nouveau comment ajouté avec succés'
      redirect_to gossip_comments_path
    else
      flash[:failure] = 'Echec lors de la création du comment, veuillez réessayer'
      render :new
    end
  end

  def edit
  end

  def update
    @comment.update(post_params)
    redirect_to gossip_comments_path
  end

  def destroy
    @comment.destroy
    redirect_to gossip_comments_path
  end

  private

  def post_params
    params.require(:comment).permit(:content)
  end

  def verify_user
    unless sess_id && (get_comment.user_id == sess_id)
      flash[:failure] = 'Ou tu vas petit filou ?'
      redirect_to '/'
    end
  end

  def get_comment 
    @comment = Comment.find(params[:id])
  end

  def get_gossip
    @gossip = Gossip.find(params[:gossip_id])
  end
end
