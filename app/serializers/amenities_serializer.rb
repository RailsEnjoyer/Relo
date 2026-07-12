# frozen_string_literal: true

class AmenitiesSerializer < Blueprinter::Base
  identifier :id

  view :index do
    field :title
  end
end
