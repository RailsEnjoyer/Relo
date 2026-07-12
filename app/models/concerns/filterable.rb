# frozen_string_literal: true

module Filterable
  extend ActiveSupport::Concern

  class_methods do
    def filtered(filter_params)
      filter_params.reduce(all) do |scope, (key, value)|
        next scope unless allowed_filters.include?(key.to_sym)

        scope.public_send("filter_by_#{key}", value)
      end
    end

    def allowed_filters
      []
    end
  end
end
