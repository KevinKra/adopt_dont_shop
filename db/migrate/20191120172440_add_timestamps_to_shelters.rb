class AddTimestampsToShelters < ActiveRecord::Migration[5.1]
  def change
    add_column :shelters, :created_at, :datetime
    add_column :shelters, :updated_at, :datetime
  end
end
