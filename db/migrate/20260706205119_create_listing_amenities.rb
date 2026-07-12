# frozen_string_literal: true

class CreateListingAmenities < ActiveRecord::Migration[8.1]
  def change
    create_table :listing_amenities do |t|
      t.references :amenity, null: false, foreign_key: true
      t.references :listing, null: false, foreign_key: true

      t.float :quantity, default: 0
      t.text :description

      t.index %i[listing_id amenity_id], unique: true

      t.timestamps
    end
  end
end
