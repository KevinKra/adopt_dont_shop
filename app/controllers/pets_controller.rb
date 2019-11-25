class PetsController < ApplicationController
  def index
    @animals = Animal.all
  end

  def create
    Animal.create(animal_params)
  end

  def show
    @pet = Animal.find(params[:id])
  end

    private
    def animal_params
      params.permit(:name, :age, :image, :description, :sex)
    end
end