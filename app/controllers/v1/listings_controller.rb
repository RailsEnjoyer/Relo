# frozen_string_literal: true

class V1::ListingsController < ApplicationController
  def index
    pagy_obj, listings = pagy(Listing.all)
    serialized_listings = ListingsSerializer.render_as_hash(listings.includes(:amenities), view: :index)

    success_response(extra: { listings: serialized_listings, meta: default_meta(pagy_obj) })
  end
end
