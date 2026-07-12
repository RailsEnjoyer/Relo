# frozen_string_literal: true

# == Schema Information
#
# Table name: listings
#
#  id               :bigint           not null, primary key
#  address          :string
#  amenities        :string           default([]), is an Array
#  available_from   :date
#  bathrooms        :decimal(3, 1)
#  bedrooms         :integer
#  buy_price        :decimal(10, 2)   default(0.0)
#  image_urls       :string           default([]), is an Array
#  landlord_contact :string
#  last_synced_at   :datetime
#  latitude         :float
#  longitude        :float
#  offer_type       :integer          default(0), not null
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
  include Filterable
  include Sortable

  RANGE_FILTER_COLUMNS = %i[rent_price buy_price bedrooms bathrooms].freeze

  belongs_to :neighborhood
  has_many :saved_listings, dependent: :destroy
  has_many :favorited_by, through: :saved_listings, source: :user

  enum :status, { available: 0, pending: 1, rented: 2, deprecated: 3 }
  enum :offer_type, { rent: 0, purchase: 1 }

  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  scope :filter_by_title, ->(title) { where('title ILIKE ?', "%#{title}%") }
  scope :filter_by_status, ->(status) { where(status:) }
  scope :filter_by_offer_type, ->(offer_type) { where(offer_type:) }
  scope :filter_by_state, ->(name) { joins(neighborhood: { city: :state }).where(states: { name: }) }
  scope :filter_by_city, ->(name) { joins(neighborhood: :city).where(cities: { name: }) }
  scope :filter_by_neighborhood, ->(name) { joins(:neighborhood).where(neighborhoods: { name: }) }
  scope :filter_by_amenities, lambda { |ids|
    matching_ids = joins(:amenities)
                   .where(amenities: { id: ids })
                   .group('listings.id')
                   .having('COUNT(DISTINCT amenities.id) = ?', ids.size)
                   .select('listings.id')

    where(id: matching_ids)
  }
  scope :filter_by_deal_breakers, lambda { |titles|
    where.not(id: joins(:amenities).where(amenities: { title: titles }).select(:id))
  }

  RANGE_FILTER_COLUMNS.each do |column|
    scope :"filter_by_min_#{column}", ->(v) { where(column => v..) }
    scope :"filter_by_max_#{column}", ->(v) { where(column => ..v) }
  end

  scope :sort_by_rent_price_asc, -> { order(rent_price: :asc) }
  scope :sort_by_rent_price_desc, -> { order(rent_price: :desc) }
  scope :sort_by_buy_price_asc, -> { order(buy_price: :asc) }
  scope :sort_by_buy_price_desc, -> { order(buy_price: :desc) }

  def self.allowed_filters
    %i[title status offer_type state city neighborhood amenities deal_breakers] +
      RANGE_FILTER_COLUMNS.flat_map { [:"min_#{_1}", :"max_#{_1}"] }
  end

  def self.allowed_sorts
    %i[rent_price_asc rent_price_desc buy_price_asc buy_price_desc]
  end
end
