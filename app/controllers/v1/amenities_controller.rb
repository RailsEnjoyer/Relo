# frozen_string_literal: true

class V1::AmenitiesController < ApplicationController
  def index
    amenities = Amenity.all

    success_response(extra: { amenities: AmenitiesSerializer.render_as_hash(amenities, view: :index) })
  end
end
