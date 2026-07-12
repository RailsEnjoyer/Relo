# frozen_string_literal: true

class RemoveAmenitiesFromListings < ActiveRecord::Migration[8.1]
  def change
    remove_column :listings, :amenities, :string, array: true, default: []
  end
end
