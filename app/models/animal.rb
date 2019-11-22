class Animal < ApplicationRecord
  belongs_to :shelter
  validates_presence_of :name, :age
  validates_inclusion_of :adopted, :in => [true, false]
  # shoulda matcher
  def self.animal_count
    Animal.count
  end
end