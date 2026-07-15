# frozen_string_literal: true

# == Schema Information
#
# Table name: neighborhoods
#
#  id                   :bigint           not null, primary key
#  average_buy_price    :decimal(10, 2)   default(0.0), not null
#  average_rent_price   :decimal(10, 2)   default(0.0), not null
#  cost_of_living_index :integer
#  crime_index          :integer
#  description          :text
#  name                 :string           not null
#  school_rating        :float
#  tags                 :string           default([]), is an Array
#  walkability_score    :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  city_id              :bigint           not null
#
# Indexes
#
#  index_neighborhoods_on_city_id           (city_id)
#  index_neighborhoods_on_city_id_and_name  (city_id,name) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (city_id => cities.id)
#
class Neighborhood < ApplicationRecord
  include Filterable

  belongs_to :city

  has_many :listings, dependent: :destroy

  delegate :name, to: :city, prefix: true
  delegate :state_name, to: :city

  scope :filter_by_city_id, ->(city_id) { where(city_id:) }

  def self.allowed_filters
    %i[city_id]
  end
end
