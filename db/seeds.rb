# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   Character.create(name: 'Luke', movie: movies.first)


# puts "Cleaning database..."
Flat.destroy_all

# puts "Creating flats..."
# flats = { title: 'star house', address: 'miraflores', price_per_night: 25, number_of_pets: 2, description: 'Casa de 230mt2 con jardin interno', user_id: 1 }

# [ flats ].each do |attributes|
#   flat = Flat.create!(attributes)
#   puts "Created #{flat.title}"
# end
# puts "Finished!"