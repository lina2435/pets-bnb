class CreateFlats < ActiveRecord::Migration[6.0]
  def change
    create_table :flats do |t|
      t.string :address
      t.string :title
      t.integer :price_per_night
      t.integer :number_of_pets
      t.text :description

      t.timestamps
    end
  end
end
