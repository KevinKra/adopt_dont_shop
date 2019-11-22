class Shelter < ApplicationRecord
  has_many :animals

  validates_presence_of :name

  def self.shelter_count
    Shelter.count
  end
end