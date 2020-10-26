class GossipsController < ApplicationController
  def names
    puts params[:name]
    @gossip = Gossip.find_by(title: params[:name])
  end
end
