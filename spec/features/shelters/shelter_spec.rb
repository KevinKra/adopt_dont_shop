require 'rails_helper'

RSpec.describe "As a visitor" do
  before(:each) do
    @shelter_1 = Shelter.create(name: "RoofsPark", address: "555 Doggo Lane", city: "Denver", state: "Colorado", zip: "55455")
    @shelter_2 = Shelter.create(name: "DoogStoor", address: "123 Capital St", city: "Aurora", state: "Colorado", zip: "31331")
    @pet_1 = Animal.create!(name: "Wilson", age: 5, adopted: false, sex: "male", description: "Tall and fluffy", image: "abc", shelter_id: @shelter_1.id)
    @pet_2 = Animal.create!(name: "Tychus", age: 7, adopted: false, sex: "female", description: "Fat and hairless", image: "efg", shelter: @shelter_1)
    @pet_3 = @shelter_2.animals.create!(name: "Orson", age: 13, adopted: false, sex: "female", description: "Thin and Poofy", image: "cde")
  end

  describe "I visit the shelter's index page" do
    it "it will display all the available shelter locations" do
      visit "/shelters"

      expect(page).to have_content(@shelter_1.name)
      expect(page).to have_content(@shelter_2.name)
    end

    it "it will redirect me to the edit page when I click the edit link" do
      visit "/shelters"
      first(".card-template-1").click_link "Edit"
      expect(current_path).to eq("/shelters/#{@shelter_1.id}/edit")
    end
  end

  describe "I visit a shelter's show page" do
    it "then I see only the shelter's animal listing" do

      visit "/shelters/#{@shelter_1.id}"

      expect(page).to have_content(@shelter_1.name)
      expect(page).to have_content(@shelter_1.address)
      expect(page).to_not have_content(@shelter_2.name)
    end

    it "then I can click a link to see all of that shelter's pets" do
      visit "/shelters/#{@shelter_1.id}"

      click_link "View Pets"

    end
  end

  describe "When I visit the new shelter page form by clicking a link on the index" do
    it "I can create a new shelter" do
      visit "/shelters"

      click_link "New Shelter"

      expect(current_path).to eq("/shelters/new")

      fill_in "Name", with: "DogsForRent"
      fill_in "Address", with: "123 WoofWood Rd"
      fill_in "City", with: "Dallas"
      fill_in "State", with: "Texas"
      fill_in "Zip", with: "55414"
      click_on "Create Shelter"

      expect(current_path).to eq("/shelters")
      expect(page).to have_content("DogsForRent")
    end
  end

  describe "When I vist the edit shelter page by clicking a link on the show page" do
    it "I can edit the previously matched shelter" do
      visit "/shelters/#{@shelter_1.id}"

      click_link "Edit"

      expect(current_path).to eq("/shelters/#{@shelter_1.id}/edit")

      fill_in 'Name', with: "NewName"
      fill_in 'Address', with: "NewAddress"
      fill_in 'City', with: "NewCity"
      fill_in 'State', with: "NewState"
      fill_in 'Zip', with: 123123
      click_on "Update Shelter"

      expect(current_path).to eq("/shelters/#{@shelter_1.id}")
      expect(page).to have_content("NewName")
      expect(page).to have_content("NewAddress")
      expect(page).to have_content("NewCity")
      expect(page).to have_content("NewState")
      expect(page).to have_content(123123)
    end

    it "I can return to the shelters index page" do 
      visit "/shelters/#{@shelter_1.id}/edit"
      click_link "Home"
      expect(current_path).to eq("/shelters")
    end

    it "I can delete the previously matched shelter" do
      visit "/shelters/#{@shelter_1.id}"
      expect(Shelter.shelter_count).to eq(2)
      expect(current_path).to eq("/shelters/#{@shelter_1.id}")
      click_button "Delete"
      expect(current_path).to eq("/shelters")
      expect(Shelter.shelter_count).to eq(1)
    end
  end

  describe "I visit the shelter's pet page" do
    it "and it will show all the shelter's pets" do
      visit "/shelters/#{@shelter_1.id}/pets"
      expect(page).to have_content(@pet_1.name)
      expect(page).to have_content(@pet_1.image)
      expect(page).to have_content(@pet_1.age)
      expect(page).to have_content(@pet_1.sex)
      expect(page).to_not have_content(@pet_3.name)
    end

    it "and it will allow me to edit any pet" do
      visit "/shelters/#{@shelter_1.id}/pets"
      first(".card-template-1").click_link "Edit"
      expect(current_path).to eq("/pets/#{@pet_1.id}/edit")

      fill_in "Name", with: "Azimoth"
      fill_in "image", with: "my_new_image.jpg"
      fill_in "age", with: 33
      page.choose('sex_male')
      fill_in "description", with: "A strong but old dog"
      page.choose('adopted_false')
      click_on "Update"

      expect(current_path).to eq("/pets")

      expect(page).to have_content("Azimoth")
    end

    it "and it will allow me to delete any pet" do
      visit "/shelters/#{@shelter_1.id}/pets"
      first(".card-template-1").click_button "delete"
      expect(current_path).to eq("/pets")
      expect(page).to_not have_content(@pet_1.name)
    end

    it "and it will direct me to the add pets page" do
      visit "/shelters/#{@shelter_1.id}/pets"
      click_link "New Pet"
      expect(current_path).to eq("/shelters/#{@shelter_1.id}/pets/new")
    end
  end

  describe "I visit the add pet to a shelter page" do
    it "I can add a pet to a given shelter's total pets" do

      visit "/shelters/#{@shelter_1.id}/pets/new"

      fill_in "Name", with: "Gregory"
      fill_in "Image", with: "Image_of_greg.jpg"
      fill_in "Age", with: 12
      page.choose('sex_male')
      fill_in "Description", with: "A fantastic dog!"
      page.choose('adopted_false')
      click_on "Create Pet"

      expect(current_path).to eq("/shelters/#{@shelter_1.id}/pets")
      expect(page).to have_content("Gregory")
      expect(page).to have_content("Image_of_greg.jpg")
      expect(page).to_not have_content("A fantastic dog!")
    end
  end
end
