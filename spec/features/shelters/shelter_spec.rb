require 'rails_helper'

RSpec.describe "As a visitor" do
  before(:each) do
    @shelter_1 = Shelter.create(name: "RoofsPark", address: "555 Doggo Lane", city: "Denver", state: "Colorado", zip: "55455")
    @shelter_2 = Shelter.create(name: "DoogStoor", address: "123 Capital St", city: "Aurora", state: "Colorado", zip: "31331")
    @animal_1 = Animal.create(name: "Wilson", age: 5, adopted: false, shelter_id: @shelter_1.id)
    @animal_2 = Animal.create(name: "Tychus", age: 7, adopted: false, shelter: @shelter_1)
  end

  describe "I visit a shelter's show page" do
    it "then I see only the shelter's animal listing" do

      visit "/shelters/#{@shelter_1.id}"

      expect(page).to have_content(@shelter_1.name)
      expect(page).to have_content(@shelter_1.address)
      expect(page).to_not have_content(@shelter_2.name)
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

    it "I can delete the previously matched shelter" do
      visit "/shelters/#{@shelter_1.id}"
      expect(Shelter.shelter_count).to eq(2)
      expect(current_path).to eq("/shelters/#{@shelter_1.id}")
      click_link "Delete"
      expect(current_path).to eq("/shelters")
      expect(Shelter.shelter_count).to eq(1)
    end
  end
end
