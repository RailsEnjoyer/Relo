# frozen_string_literal: true

MoveTimelineItem.destroy_all

default_user = User.find_by!(email_address: 'r3ka1to@gmail.com')

TEMPLATE = [
  {
    title: 'Choose destination',
    description: 'Pick the target city and neighborhood to focus your search on.',
    notes: ['Compare cost of living', 'Check job market', 'Review climate'],
    days_from_now: -60,
    status: :completed
  },
  {
    title: 'Research neighborhoods',
    description: 'Compare shortlisted neighborhoods by walkability, safety, schools, and commute.',
    notes: ['Walk score above 70', 'Crime index acceptable', 'Near public transit'],
    days_from_now: -45,
    status: :completed
  },
  {
    title: 'Compare apartments',
    description: 'Shortlist 5-10 apartments matching budget and must-haves.',
    notes: ['Set filters', 'Save favorites', 'Compare monthly cost'],
    days_from_now: -20,
    status: :completed
  },
  {
    title: 'Sign apartment lease',
    description: 'Review lease terms with landlord and sign the final agreement.',
    notes: ['Need parking spot', 'Confirm pet policy', 'Ask about guest parking'],
    days_from_now: 5,
    status: :in_progress
  },
  {
    title: 'Book movers',
    description: 'Get quotes from moving companies and book the one that fits budget and schedule.',
    notes: ['Request 3+ quotes', 'Check insurance coverage', 'Confirm move date'],
    days_from_now: 20,
    status: :upcoming
  },
  {
    title: 'Utilities setup',
    description: 'Set up electricity, water, gas, internet at the new place.',
    notes: ['Electricity provider', 'Internet plan', 'Water/gas activation'],
    days_from_now: 30,
    status: :upcoming
  },
  {
    title: 'Change address',
    description: 'Update address with USPS, bank, subscriptions, and government offices.',
    notes: ['USPS forwarding', 'Update DL', 'Bank & credit cards'],
    days_from_now: 40,
    status: :upcoming
  },
  {
    title: 'Move day!',
    description: 'Execute the move and settle into the new place.',
    notes: ['Pack essentials bag', 'Confirm movers arrival', 'Do final walkthrough'],
    days_from_now: 45,
    status: :upcoming
  }
].freeze

default_user.relocation_plans.find_each do |plan|
  TEMPLATE.each_with_index do |data, index|
    plan.move_timeline_items.create!(
      title: data[:title],
      description: data[:description],
      notes: data[:notes],
      position: index + 1,
      status: data[:status],
      deadline: Time.current + data[:days_from_now].days
    )
  end
end
