require 'rails_helper'

describe Shelter, type: :model do
  describe "validations" do
    it { should validate_presence_of :name }
  end

  describe "relationships" do
    it { should have_many :animals }
  end

  describe "class methods" do
    it ".shelter_count" do
      shelter_1 = Shelter.create!(name: "RoofsPark", address: "555 Doggo Lane", city: "Denver", state: "Colorado", zip: "55455")
      shelter_2 = Shelter.create!(name: "BarksPark", address: "123 Ruff Street", city: "Aurora", state: "Colorado", zip: "13313")
      animal_1 = Animal.create!(name: "Wilson", age: 5, adopted: false, shelter_id: shelter_1.id)
      animal_2 = Animal.create!(name: "Tychus", age: 7, adopted: false, shelter: shelter_1)
      animal_3 = shelter_1.animals.create!(name: "Orson", age: 13, adopted: false)

      expect(Shelter.shelter_count).to eq(2)
    end
  end

end
