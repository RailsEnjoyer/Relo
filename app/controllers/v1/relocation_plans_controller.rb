# frozen_string_literal: true

class V1::RelocationPlansController < ApplicationController
  def index
    plans = current_user.relocation_plans.includes(:city)

    relocation_plans = RelocationPlansSerializer.render_as_hash(plans, view: :index)
    success_response(extra: { relocation_plans: })
  end

  def show
    plan = current_user.relocation_plans.includes(:city).find(params[:id])

    relocation_plan = RelocationPlansSerializer.render_as_hash(plan, view: :show)
    success_response(extra: { relocation_plan: })
  end

  def create
    service = RelocationPlans::Create.call(params: relocation_plan_params, user: current_user)
    return error_reponse(errors: service.errors) if service.failure?

    success_response(extra: service.result)
  end

  private

  def relocation_plan_params
    params.expect(
      relocation_plan: [
        :title, :move_date, :monthly_rent_budget, :buy_budget, :description,
        :people_count, :priorities, :with_animals, { deal_breakers: [], must_haves: [] }
      ]
    )
  end
end
