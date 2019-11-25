require 'rails_helper'

RSpec.describe "As a visitor" do
  before(:each) do
    @shelter_1 = Shelter.create!(name: "RoofsPark", address: "555 Doggo Lane", city: "Denver", state: "Colorado", zip: "55455")
    @shelter_2 = Shelter.create!(name: "BarksPark", address: "123 Ruff Street", city: "Aurora", state: "Colorado", zip: "13313")
    @pet_1 = Animal.create!(name: "Wilson", age: 5, adopted: false, sex: "male", description: "Tall and fluffy", image: "abc", shelter_id: @shelter_1.id)
    @pet_2 = Animal.create!(name: "Tychus", age: 7, adopted: false, sex: "female", description: "Fat and hairless", image: "efg", shelter: @shelter_1)
    @pet_3 = @shelter_2.animals.create!(name: "Orson", age: 13, adopted: false, sex: "female", description: "Thin and Poofy", image: "cde")
  end

  describe "I visit the pets page" do
    it "then I see a listing of all the pets and their information" do
      visit "/pets"
      expect(page).to have_content(@pet_1.name)
      expect(page).to have_content(@pet_1.age)
      expect(page).to have_content(@pet_1.image)
      expect(page).to have_content(@pet_1.description)
      expect(page).to have_content(@pet_1.sex)
      expect(page).to have_content(@pet_1.shelter.name)
    end
  end

  describe "I visit a unique pets page" do
    it "then I see all the data related to that particular pet" do
      visit "/pets/#{@pet_1.id}"
      expect(page).to have_content(@pet_1.name)
      expect(page).to have_content(@pet_1.age)
      expect(page).to have_content(@pet_1.image)
      expect(page).to have_content(@pet_1.description)
      expect(page).to have_content(@pet_1.sex)
      expect(page).to have_content(@pet_1.adopted)
    end
  end
end