# frozen_string_literal: true

# == Schema Information
#
# Table name: cities
#
#  id                   :bigint           not null, primary key
#  average_buy_price    :decimal(10, 2)   default(0.0), not null
#  average_rent_price   :decimal(10, 2)   default(0.0), not null
#  cost_of_living_index :integer
#  crime_index          :integer
#  description          :text
#  has_water_access     :boolean          default(FALSE), not null
#  major_industries     :string           default([]), is an Array
#  name                 :string           not null
#  natural_disasters    :string           default([]), is an Array
#  population           :integer
#  walkability_score    :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  state_id             :bigint           not null
#
# Indexes
#
#  index_cities_on_state_id           (state_id)
#  index_cities_on_state_id_and_name  (state_id,name) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (state_id => states.id)
#
class City < ApplicationRecord
  include Filterable

  belongs_to :state

  has_many :neighborhoods, dependent: :destroy
  has_many :listings, through: :neighborhoods
  has_many :relocation_plans, dependent: :destroy
  has_many :users, dependent: :nullify

  delegate :name, to: :state, prefix: true

  scope :filter_by_state_id, ->(state_id) { where(state_id:) }

  def self.allowed_filters
    %i[state_id]
  end
end
