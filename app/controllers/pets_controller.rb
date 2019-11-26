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

  def edit
    show
  end

  def patch
    show
    @pet.update(
      name: params[:name],
      image: params[:image],
      age: params[:age],
      sex: params[:sex],
      description: params[:description],
      adopted: params[:adopted]
    )
    redirect_to "/pets"
  end

  def delete
    show
    @pet.delete
    redirect_to "/pets"
  end

    private
    def animal_params
      params.permit(:name, :age, :image, :description, :sex, :adopted)
    end
end