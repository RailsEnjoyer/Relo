# frozen_string_literal: true

# == Schema Information
#
# Table name: saved_listings
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  listing_id :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_saved_listings_on_listing_id              (listing_id)
#  index_saved_listings_on_user_id                 (user_id)
#  index_saved_listings_on_user_id_and_listing_id  (user_id,listing_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (listing_id => listings.id)
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :saved_listing do
    user { nil }
    listing { nil }
  end
end
