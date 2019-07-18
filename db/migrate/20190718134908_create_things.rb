class CreateThings < ActiveRecord::Migration[5.2]
  def change
    create_table :things do |t|
      t.string :name
      t.string :category
      t.string :website

      t.timestamps
    end
  end
end
