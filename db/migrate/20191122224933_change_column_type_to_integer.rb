class ChangeColumnTypeToInteger < ActiveRecord::Migration[5.1]
  def change
    change_column :shelters, :zip, 'integer USING CAST(zip AS integer)'
  end
end
