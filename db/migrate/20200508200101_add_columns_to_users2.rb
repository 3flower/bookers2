class AddColumnsToUsers2 < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :address, :string
    add_column :users, :latitube, :float
    add_column :users, :longitube, :float
  end
end
