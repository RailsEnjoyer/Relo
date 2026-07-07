# frozen_string_literal: true

# == Schema Information
#
# Table name: listings
#
#  id               :bigint           not null, primary key
#  address          :string
#  available_from   :date
#  bathrooms        :decimal(3, 1)
#  bedrooms         :integer
#  buy_price        :decimal(10, 2)   default(0.0)
#  image_urls       :string           default([]), is an Array
#  landlord_contact :string
#  last_synced_at   :datetime
#  latitude         :float
#  longitude        :float
#  offer_type       :integer          default("rent"), not null
#  property_type    :integer          default(0), not null
#  rating           :integer
#  raw_payload      :jsonb
#  rent_price       :decimal(10, 2)   default(0.0)
#  sqft             :integer
#  status           :integer          default("available"), not null
#  title            :string           not null
#  url              :string
#  with_animals     :boolean          default(FALSE), not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  neighborhood_id  :bigint
#
# Indexes
#
#  index_listings_on_neighborhood_id  (neighborhood_id)
#  index_listings_on_offer_type       (offer_type)
#  index_listings_on_url              (url) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (neighborhood_id => neighborhoods.id)
#
class Listing < ApplicationRecord
  belongs_to :neighborhood
  has_many :saved_listings, dependent: :destroy
  has_many :favorited_by, through: :saved_listings, source: :user
  has_many :listing_amenities, dependent: :destroy
  has_many :amenities, through: :listing_amenities

  delegate :city_name, :state_name, to: :neighborhood
  delegate :name, to: :neighborhood, prefix: true

  enum :status, { available: 0, pending: 1, rented: 2, deprecated: 3 }
  enum :offer_type, { rent: 0, purchase: 1 }

  geocoded_by :address
  after_validation :geocode, if: :address_changed?
end
