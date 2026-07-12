# frozen_string_literal: true

# == Schema Information
#
# Table name: states
#
#  id                   :bigint           not null, primary key
#  average_buy_price    :decimal(10, 2)   default(0.0), not null
#  average_rent_price   :decimal(10, 2)   default(0.0), not null
#  climate_category     :string
#  code                 :string           not null
#  cost_of_living_index :integer
#  crime_index          :integer
#  description          :text
#  has_water_access     :boolean          default(FALSE), not null
#  income_tax_rate      :decimal(5, 2)
#  name                 :string           not null
#  natural_disasters    :string           default([]), is an Array
#  political_leaning    :integer          default(0), not null
#  sales_tax_rate       :decimal(5, 2)
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
# Indexes
#
#  index_states_on_code  (code) UNIQUE
#  index_states_on_name  (name) UNIQUE
#
class State < ApplicationRecord
  has_many :cities, dependent: :destroy
  has_many :neighborhoods, through: :cities
  has_many :listings, through: :neighborhoods
  has_many :users, dependent: :nullify

  delegate :name, to: :city, prefix: true
end
