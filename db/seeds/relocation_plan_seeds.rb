# frozen_string_literal: true

RelocationPlan.destroy_all
Neighborhood.destroy_all

default_user = User.find_or_create_by!(email_address: 'r3ka1to@gmail.com') do |u|
  u.password = 'Password#123'
end

amenity_id = Amenity.pluck(:title, :id).to_h
resolve = ->(*titles) { titles.map { |t| amenity_id.fetch(t) } }

ca = State.find_by!(code: 'CA')
tx = State.find_by!(code: 'TX')
ny = State.find_by!(code: 'NY')
fl = State.find_by!(code: 'FL')

sf = City.find_by!(state_id: ca.id, name: 'San Francisco')
la = City.find_by!(state_id: ca.id, name: 'Los Angeles')
austin = City.find_by!(state_id: tx.id, name: 'Austin')
nyc = City.find_by!(state_id: ny.id, name: 'New York')
pensacola = City.find_by!(state_id: fl.id, name: 'Pensacola')

sf_mission = Neighborhood.create!(
  city_id: sf.id, name: 'Mission District',
  cost_of_living_index: 150,
  walkability_score: 100,
  crime_index: 110
)
la_weho = Neighborhood.create!(
  city_id: la.id,
  name: 'West Hollywood',
  cost_of_living_index: 155,
  walkability_score: 110,
  crime_index: 110
)
austin_downtown = Neighborhood.create!(
  city_id: austin.id,
  name: 'Downtown',
  cost_of_living_index: 100,
  walkability_score: 150,
  crime_index: 120
)
nyc_brooklyn = Neighborhood.create!(
  city_id: nyc.id,
  name: 'Brooklyn',
  cost_of_living_index: 140,
  walkability_score: 160,
  crime_index: 155
)
pensacola_downtown = Neighborhood.create!(
  city_id: pensacola.id,
  name: 'Downtown Pensacola',
  cost_of_living_index: 90,
  walkability_score: 85,
  crime_index: 100
)

plans = [
  {
    user_id: default_user.id,
    state_id: ca.id,
    city_id: sf.id,
    neighborhood_id: sf_mission.id,
    title: 'Move to SF Tech Hub',
    description: 'Looking for a spot close to startups and good coffee.',
    monthly_rent_budget: 3500.00,
    buy_budget: 0,
    people_count: 1,
    with_animals: false,
    must_haves: resolve.('High-Speed Internet', 'Near Public Transit', 'Air Conditioning'),
    deal_breakers: resolve.('Carpet'),
    priorities: %w[Location Budget]
  },
  {
    user_id: default_user.id,
    state_id: ca.id,
    city_id: la.id,
    neighborhood_id: la_weho.id,
    title: 'Sunny LA Relocation',
    description: 'Need a pet-friendly apartment with a pool.',
    monthly_rent_budget: 2800.00,
    buy_budget: 0,
    people_count: 2,
    with_animals: true,
    must_haves: resolve.('Pool', 'Pet Friendly', 'Parking'),
    deal_breakers: [],
    priorities: %w[Amenities Safety]
  },
  {
    user_id: default_user.id,
    state_id: tx.id,
    city_id: austin.id,
    neighborhood_id: austin_downtown.id,
    title: 'Austin Tech Relo',
    description: 'Moving for a new job, looking to buy soon.',
    monthly_rent_budget: 2000.00,
    buy_budget: 450_000.00,
    people_count: 2,
    with_animals: true,
    must_haves: resolve.('Gym', 'Balcony', 'Near Public Transit'),
    deal_breakers: [],
    priorities: ['Commute time', 'Space']
  },
  {
    user_id: default_user.id,
    state_id: ny.id,
    city_id: nyc.id,
    neighborhood_id: nyc_brooklyn.id,
    title: 'NYC Adventure',
    description: 'First time in New York, need to be near the subway.',
    monthly_rent_budget: 3200.00,
    buy_budget: 0,
    people_count: 1,
    with_animals: false,
    must_haves: resolve.('Doorman', 'Elevator'),
    deal_breakers: [],
    priorities: %w[Location Safety]
  },
  {
    user_id: default_user.id,
    state_id: fl.id,
    city_id: pensacola.id,
    neighborhood_id: pensacola_downtown.id,
    title: 'Pensacola Beach Life',
    description: 'Looking to buy a place near the water in sunny Florida.',
    monthly_rent_budget: 0,
    buy_budget: 400_000.00,
    people_count: 2,
    with_animals: true,
    must_haves: resolve.('Balcony', 'Pool', 'Parking', 'Waterfront'),
    deal_breakers: [],
    priorities: %w[Amenities Budget]
  }
]

RelocationPlan.create!(plans)
