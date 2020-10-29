class CitiesController < ApplicationController
  def show
    @city = City.find(params[:id])
    @gossips = @city.users.map{|u| u.gossips}.flatten
    @gossips.each {|g| puts g}

  end
end
