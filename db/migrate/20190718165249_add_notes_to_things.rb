class AddNotesToThings < ActiveRecord::Migration[5.2]
  def change
    add_column :things, :notes, :string
  end
end
