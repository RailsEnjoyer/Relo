# frozen_string_literal: true

class V1::CitiesController < ApplicationController
  def index
    cities = City.filtered(filter_params)

    success_response(extra: { cities: CitiesSerializer.render_as_hash(cities, view: :index) })
  end

  private

  def filter_params
    params.permit(*City.allowed_filters).to_h
  end
end
