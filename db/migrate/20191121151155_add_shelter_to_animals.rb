class AddShelterToAnimals < ActiveRecord::Migration[5.1]
  def change
    add_reference :animals, :shelter, foreign_key: true
  end
end
