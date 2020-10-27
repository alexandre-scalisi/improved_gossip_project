class GossipsController < ApplicationController
  def names
    puts params[:name]
    @gossip = Gossip.find_by(title: params[:name])
  end

  def new
    @gossips = Gossip.all
  end

  def create
    gossip = Gossip.new(title: params[:title],content: params[:content], user: User.first)

    if gossip.save
      flash[:success] = "Nouveau gossip ajouté avec succés"
      redirect_to home_path
    else
      flash[:failure] = "Echec lors de la création du gossip, veuillez réessayer"
      redirect_to request.referrer
    end
  end
end
