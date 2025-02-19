class Shelter < ApplicationRecord
  has_many :animals, dependent: :destroy

  validates_presence_of :name, :city, :state, :zip, :address

  def self.shelter_count
    Shelter.count
  end

  def first_animal
    self.animals.first
  end

  def avg_animal_age
    self.animals.average(:age)
  end
end