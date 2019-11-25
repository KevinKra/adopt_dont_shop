class AddSexImageDescToAnimals < ActiveRecord::Migration[5.1]
  def change
    add_column :animals, :sex, :string
    add_column :animals, :description, :text
    add_column :animals, :image, :string
  end
end
