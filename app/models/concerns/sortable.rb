# frozen_string_literal: true

module Sortable
  extend ActiveSupport::Concern

  class_methods do
    def sorted(sort_key)
      return all if sort_key.blank?
      return all unless allowed_sorts.include?(sort_key.to_sym)

      public_send("sort_by_#{sort_key}")
    end

    def allowed_sorts
      []
    end
  end
end
