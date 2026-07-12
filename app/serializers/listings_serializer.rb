# frozen_string_literal: true

class ListingsSerializer < Blueprinter::Base
  identifier :id

  fields :rent_price, :bedrooms, :bathrooms, :title, :image_urls

  view :index do
    fields :status, :longitude, :latitude, :offer_type

    field :city, &:city_name
    field :state, &:state_name
    field :neighborhood, &:neighborhood_name

    field :match do |listing, options|
      Listings::MatchCalculator.call(listing:, plan: options[:plan]).result if options[:plan].present?
    end

    association :amenities, blueprint: AmenitiesSerializer, view: :index
  end
end
