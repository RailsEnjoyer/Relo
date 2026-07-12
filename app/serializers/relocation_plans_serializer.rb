# frozen_string_literal: true

class RelocationPlansSerializer < Blueprinter::Base
  identifier :id

  fields :title

  field :target_city do |e|
    e&.city&.name
  end

  view :index do
    fields :monthly_rent_budget, :buy_budget, :must_haves, :deal_breakers, :bedrooms, :bathrooms
  end

  view :show do
    fields :monthly_rent_budget, :move_date

    field :top_matches do |plan|
      ListingsSerializer.render_as_hash(
        Current.session.user.top_matching_favorites(plan, limit: 10), view: :index, plan:
      )
    end
  end
end
