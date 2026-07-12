# frozen_string_literal: true

AMENITIES = [
  # In-unit
  'Air Conditioning',
  'Heating',
  'Central Air',
  'Central Heating',
  'Ceiling Fan',
  'Hardwood Floors',
  'Carpet',
  'Tile Floors',
  'Fireplace',
  'Walk-in Closet',
  'Furnished',
  'Balcony',
  'Patio',
  'Private Yard',
  'View',
  'Skylight',
  'High Ceilings',
  'Bay Windows',
  'Recessed Lighting',

  # Kitchen
  'Dishwasher',
  'Microwave',
  'Refrigerator',
  'Oven',
  'Stove',
  'Garbage Disposal',
  'Granite Countertops',
  'Stainless Steel Appliances',
  'Kitchen Island',
  'Pantry',
  'Wine Cooler',

  # Bathroom
  'Bathtub',
  'Walk-in Shower',
  'Double Vanity',
  'Jacuzzi',
  'Heated Floors',

  # Laundry
  'Washer/Dryer',
  'Washer/Dryer Hookups',
  'In-Unit Laundry',
  'Shared Laundry',

  # Building
  'Elevator',
  'Doorman',
  'Concierge',
  'Package Room',
  'Bike Storage',
  'Storage Unit',
  'Security System',
  'Controlled Access',
  'Video Intercom',
  'On-Site Management',
  'On-Site Maintenance',

  # Building amenities
  'Pool',
  'Hot Tub',
  'Sauna',
  'Gym',
  'Fitness Center',
  'Yoga Studio',
  'Rooftop',
  'Rooftop Deck',
  'Rooftop Pool',
  'Lounge',
  'Business Center',
  'Coworking Space',
  'Conference Room',
  'Movie Theater',
  'Game Room',
  'Library',
  'Community Kitchen',
  'BBQ Area',
  'Fire Pit',
  'Outdoor Kitchen',
  'Playground',
  'Basketball Court',
  'Tennis Court',

  # Parking
  'Parking',
  'Garage Parking',
  'Covered Parking',
  'Street Parking',
  'EV Charging',
  'Bike Parking',

  # Pets
  'Pet Friendly',
  'Cats Allowed',
  'Dogs Allowed',
  'Dog Run',
  'Dog Wash Station',

  # Connectivity
  'High-Speed Internet',
  'Fiber Internet',
  'Cable Ready',
  'Smart Home',
  'Smart Thermostat',
  'Smart Locks',

  # Accessibility
  'Wheelchair Accessible',
  'Grab Bars',
  'Roll-in Shower',
  'Wide Doorways',

  # Green / utilities
  'Solar Panels',
  'Energy Efficient Appliances',
  'LED Lighting',
  'Double-Pane Windows',
  'Recycling',
  'Composting',

  # Location perks
  'Waterfront',
  'Ocean View',
  'Mountain View',
  'City View',
  'Park View',
  'Near Public Transit',
  'Near Highway',
  'Walk to Downtown',

  # Outdoor
  'Garden',
  'Landscaped',
  'Private Entrance',
  'Front Porch',
  'Deck',

  # Extras
  'Gated Community',
  'HOA',
  'Age Restricted',
  'Short-Term Lease Available',
  'Long-Term Lease Available',
  'Utilities Included',
  'Water Included',
  'Gas Included',
  'Trash Included',
  'Snow Removal',
  'Lawn Care'
].freeze

AMENITIES.each do |title|
  Amenity.find_or_create_by!(title: title)
end
