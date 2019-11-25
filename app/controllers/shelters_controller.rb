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

  def edit
    show
  end

  def patch
    show
    @shelter.update(
                    name: params[:name], 
                    address: params[:address],
                    city: params[:city],
                    state: params[:state],
                    zip: params[:zip]
                  )
    redirect_to "/shelters/#{@shelter.id}"
  end

  def delete
    show
    shelter = Shelter.find(@shelter.id)
    shelter.destroy
    redirect_to "/shelters"
  end

  def show
    @shelter = Shelter.find(params[:id])
  end

  private
  def shelter_params
    params.permit(:name, :address, :city, :state, :zip)
  end
end