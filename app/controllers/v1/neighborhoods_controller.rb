# frozen_string_literal: true

class V1::NeighborhoodsController < ApplicationController
  def index
    neighborhoods = Neighborhood.filtered(filter_params)

    success_response(extra: { neighborhoods: NeighborhoodsSerializer.render_as_hash(neighborhoods, view: :index) })
  end

  private

  def filter_params
    params.permit(*Neighborhood.allowed_filters).to_h
  end
end
