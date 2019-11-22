class SheltersController < ApplicationController
  def index
    @shelters = Shelter.all
  end

  def new
  end

  def create
    Shelter.create(shelter_params)
    redirect_to "/shelters"
  end

  def show
    @shelter = Shelter.find(params[:id])
  end

  private
  def shelter_params
    params.permit(:name)
  end
end