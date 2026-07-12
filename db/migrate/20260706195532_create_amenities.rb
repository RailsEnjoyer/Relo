# frozen_string_literal: true

class CreateAmenities < ActiveRecord::Migration[8.1]
  def change
    create_table :amenities do |t|
      t.string :title

      t.timestamps
    end
  end
end
