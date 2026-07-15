# frozen_string_literal: true

# == Schema Information
#
# Table name: relocation_plans
#
#  id                  :bigint           not null, primary key
#  bathrooms           :integer
#  bedrooms            :integer
#  buy_budget          :decimal(10, 2)
#  deal_breakers       :integer          default([]), not null, is an Array
#  description         :text
#  latitude            :float
#  longitude           :float
#  monthly_rent_budget :decimal(10, 2)
#  move_date           :datetime
#  must_haves          :integer          default([]), not null, is an Array
#  people_count        :integer          default(1), not null
#  priorities          :string           default([]), is an Array
#  property_type       :string
#  sqft                :integer
#  title               :string
#  with_animals        :boolean          default(FALSE), not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  city_id             :bigint
#  neighborhood_id     :bigint
#  state_id            :bigint
#  user_id             :bigint
#
# Indexes
#
#  index_relocation_plans_on_city_id          (city_id)
#  index_relocation_plans_on_neighborhood_id  (neighborhood_id)
#  index_relocation_plans_on_state_id         (state_id)
#  index_relocation_plans_on_title            (title)
#  index_relocation_plans_on_user_id          (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (city_id => cities.id)
#  fk_rails_...  (neighborhood_id => neighborhoods.id)
#  fk_rails_...  (state_id => states.id)
#  fk_rails_...  (user_id => users.id)
#
class RelocationPlan < ApplicationRecord
  has_many :move_timeline_items, -> { order(:position) }, inverse_of: :relocation_plan, dependent: :destroy

  belongs_to :neighborhood
  belongs_to :state
  belongs_to :city
  belongs_to :user

  validates :monthly_rent_budget, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates :buy_budget, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true

  def full_address
    [neighborhood&.name, city&.name, state&.name].compact.join(', ')
  end

  geocoded_by :full_address
  after_validation :geocode
end
