# frozen_string_literal: true

require 'securerandom'

Listing.destroy_all

neighborhoods = Neighborhood.all
property_types = [0, 1, 2, 3]
statuses = [0, 1]
amenity_options = ['Pool', 'Gym', 'Parking', 'Washer/Dryer', 'Balcony', 'Dishwasher', 'AC']

listings = []
bathrooms_count = [1.0, 1.5, 2.0, 2.5]

house_images = [
  'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?w=800',
  'https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?w=800',
  'https://images.unsplash.com/photo-1580587771525-78b9dba3b914?w=800',
  'https://images.unsplash.com/photo-1564013799919-ab600027ffc6?w=800',
  'https://images.unsplash.com/photo-1576941089067-2de3c901e126?w=800',
  'https://images.unsplash.com/photo-1570129477492-45c003edd2be?w=800',
  'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?w=800',
  'https://images.unsplash.com/photo-1513694203232-719a280e022f?w=800',
  'https://images.unsplash.com/photo-1583608205776-bfd35f0d9f83?w=800',
  'https://images.unsplash.com/photo-1568605114967-8130f3a36994?w=800'
]

apartment_images = [
  'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=800',
  'https://images.unsplash.com/photo-1502672260266-1c1e525048c7?w=800',
  'https://images.unsplash.com/photo-1560448204-e02f11c3d0e2?w=800',
  'https://images.unsplash.com/photo-1493809842364-78817add7ffb?w=800',
  'https://images.unsplash.com/photo-1502005229762-cf1b2da7c5d6?w=800'
]

real_locations = {
  'San Francisco' => [
    { address: '3500 19th St, San Francisco, CA' },
    { address: '824 Valencia St, San Francisco, CA' },
    { address: '2001 16th St, San Francisco, CA' },
    { address: '1000 Valencia St, San Francisco, CA' },
    { address: '600 S Van Ness Ave, San Francisco, CA' }
  ],
  'Los Angeles' => [
    { address: '8822 Cynthia St, West Hollywood, CA' },
    { address: '9015 Cynthia St, West Hollywood, CA' },
    { address: '1230 Horn Ave, West Hollywood, CA' },
    { address: '1111 N Doheny Dr, West Hollywood, CA' },
    { address: '1000 N La Cienega Blvd, West Hollywood, CA' }
  ],
  'Austin' => [
    { address: '300 W 6th St, Austin, TX' },
    { address: '400 W 2nd St, Austin, TX' },
    { address: '500 E 4th St, Austin, TX' },
    { address: '100 Congress Ave, Austin, TX' },
    { address: '600 Brazos St, Austin, TX' }
  ],
  'New York' => [
    { address: '150 N 12th St, Brooklyn, NY' },
    { address: '200 Water St, Brooklyn, NY' },
    { address: '100 Jay St, Brooklyn, NY' },
    { address: '50 Bridge St, Brooklyn, NY' },
    { address: '110 Livingston St, Brooklyn, NY' }
  ],
  'Pensacola' => [
    { address: '100 E Wright St, Pensacola, FL' },
    { address: '200 S Alcaniz St, Pensacola, FL' },
    { address: '500 S Palafox St, Pensacola, FL' },
    { address: '120 E Main St, Pensacola, FL' },
    { address: '300 W Cervantes St, Pensacola, FL' }
  ]
}

neighborhoods.each do |neighborhood|
  city_name = neighborhood.city.name
  locations = real_locations[city_name] || real_locations['San Francisco']

  rand(3..5).times do |i|
    prop_type = property_types.sample
    location = locations.sample
    is_rental = [true, false].sample

    selected_images = if prop_type < 2
                        house_images.sample(2)
                      else
                        apartment_images.sample(2)
                      end

    listings << {
      neighborhood_id: neighborhood.id,
      url: "https://relo-fake-listing.com/#{neighborhood.id}-#{i}-#{SecureRandom.hex(4)}",
      title: "Beautiful #{prop_type < 2 ? 'Home' : 'Apartment'} in #{neighborhood.name}",
      address: location[:address],
      rent_price: is_rental ? (rand(1500..6000) * 1.0).round(2) : nil,
      buy_price: is_rental ? nil : (rand(300_000..1_500_000) * 1.0).round(2),
      bedrooms: rand(1..4),
      bathrooms: bathrooms_count.sample,
      sqft: rand(500..2500),
      property_type: prop_type,
      available_from: Time.zone.now + rand(1..30).days,
      rating: rand(3..5),
      amenities: amenity_options.sample(rand(2..5)),
      status: statuses.sample,
      image_urls: selected_images,
      with_animals: [true, false].sample
    }
  end
end

listings.each_with_index do |attrs, index|
  warn "\rProcessing listing #{index + 1}/#{listings.size}..."
  Listing.create!(attrs)
  sleep 1.5
end
