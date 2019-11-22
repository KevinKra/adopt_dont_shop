require 'rails_helper'

describe Shelter, type: :model do
  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_presence_of :zip }
    it { should validate_presence_of :address }
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

  describe "instance methods" do
    it ".avg_animal_age" do
      shelter_1 = Shelter.create!(name: "RoofsPark", address: "555 Doggo Lane", city: "Denver", state: "Colorado", zip: "55455")
      shelter_2 = Shelter.create!(name: "BarksPark", address: "123 Ruff Street", city: "Aurora", state: "Colorado", zip: "13313")
      animal_1 = Animal.create!(name: "Stockade", age: 8, adopted: false, shelter: shelter_1);
      animal_2 = Animal.create!(name: "Spider", age: 6, adopted: false, shelter_id: shelter_1.id)
      animal_3 = shelter_2.animals.create(name: "Scout", age: 12, adopted: false)

      expect(shelter_1.avg_animal_age).to eq(7)
      expect(shelter_2.avg_animal_age).to eq(12)
    end

    it ".first_animal" do 
      shelter_1 = Shelter.create!(name: "RoofsPark", address: "555 Doggo Lane", city: "Denver", state: "Colorado", zip: "55455")
      shelter_2 = Shelter.create!(name: "BarksPark", address: "123 Ruff Street", city: "Aurora", state: "Colorado", zip: "13313")
      animal_1 = Animal.create!(name: "Wilson", age: 5, adopted: false, shelter_id: shelter_1.id)
      animal_2 = Animal.create!(name: "Tychus", age: 7, adopted: false, shelter: shelter_1)
      animal_3 = shelter_1.animals.create!(name: "Orson", age: 13, adopted: false)

      expect(shelter_1.first_animal).to eq(animal_1)
    end
  end
end