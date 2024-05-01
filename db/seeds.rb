# Require necessary libraries
require 'httparty'
require 'faker'

# Define the number of random flats to generate
number_of_flats = 20

# Iterate to generate 20 random flats
number_of_flats.times do
  flat_data = {
    name: Faker::Lorem.sentence(word_count: 3),
    address: Faker::Address.full_address,
    description: Faker::Lorem.paragraph(sentence_count: 4),
    price_per_night: rand(50..300),
    number_of_guests: rand(1..10)
  }

  flat = Flat.new(flat_data)
  flat.fetch_random_image
  flat.save!
end
