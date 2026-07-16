# frozen_string_literal: true

class NeighborhoodsSerializer < Blueprinter::Base
  identifier :id

  view :guest_index do
    fields :name, :cost_of_living_index, :crime_index, :walkability_score, :school_rating
  end

  view :index do
    fields :name
  end
end
