class PetsController < ApplicationController
  def index
    @animals = Animal.all
  end

  def new
    @shelter = Shelter.find(params[:id])
  end

  def create
    @shelter = Shelter.find(params[:id])
    @shelter.animals.create(animal_params)
    redirect_to "/shelters/#{@shelter.id}/pets"
  end

  def show
    @pet = Animal.find(params[:id])
  end

    private
    def animal_params
      params.permit(:name, :age, :image, :description, :sex, :adopted)
    end
end