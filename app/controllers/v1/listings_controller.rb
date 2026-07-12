# frozen_string_literal: true

class V1::ListingsController < ApplicationController
  def index
    pagy_obj, listings = pagy(Listing.filtered(filter_params).sorted(params[:sort_by]))
    serialized_listings = ListingsSerializer.render_as_hash(listings.includes(:amenities), view: :index)

    success_response(extra: { listings: serialized_listings, meta: default_meta(pagy_obj) })
  end

  private

  def filter_params
    params.permit(*Listing.allowed_filters, amenities: [], deal_breakers: []).to_h
  end
end
