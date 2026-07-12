# frozen_string_literal: true

# == Schema Information
#
# Table name: amenities
#
#  id         :bigint           not null, primary key
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Amenity < ApplicationRecord
  has_many :listing_amenities, dependent: :destroy
  has_many :listings, through: :listing_amenities
end
