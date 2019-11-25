require 'rails_helper'

describe Shelter, type: :model do
  before(:each) do
    @shelter_1 = Shelter.create(name: "RoofsPark", address: "555 Doggo Lane", city: "Denver", state: "Colorado", zip: "55455")
    @shelter_2 = Shelter.create(name: "DoogStoor", address: "123 Capital St", city: "Aurora", state: "Colorado", zip: "31331")
    @pet_1 = Animal.create!(name: "Wilson", age: 5, adopted: false, sex: "male", description: "Tall and fluffy", image: "abc", shelter_id: @shelter_1.id)
    @pet_2 = Animal.create!(name: "Tychus", age: 7, adopted: false, sex: "female", description: "Fat and hairless", image: "efg", shelter: @shelter_1)
    @pet_3 = @shelter_2.animals.create!(name: "Orson", age: 13, adopted: false, sex: "female", description: "Thin and Poofy", image: "cde")
  end

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

      expect(Shelter.shelter_count).to eq(2)
    end
  end

  describe "instance methods" do
    it ".avg_animal_age" do
      expect(@shelter_1.avg_animal_age).to eq(6)
      expect(@shelter_2.avg_animal_age).to eq(13)
    end

    it ".first_animal" do 
      expect(@shelter_1.first_animal).to eq(@pet_1)
    end
  end
end