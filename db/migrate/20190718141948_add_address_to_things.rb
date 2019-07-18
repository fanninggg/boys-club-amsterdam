class AddAddressToThings < ActiveRecord::Migration[5.2]
  def change
    add_column :things, :address, :string
  end
end
