# frozen_string_literal: true

class V1::MoveTimelineItemsController < ApplicationController
  def index
    move_timeline_items = relocation_plan.move_timeline_items

    success_response(
      extra: { move_timeline_items: MoveTimelineItemsSerializer.render_as_hash(move_timeline_items, view: :index) }
    )
  end

  def create
    result = relocation_plan.move_timeline_items.create(move_timeline_items_params)

    render_result(
      result:, success: { move_timeline_item: MoveTimelineItemsSerializer.render_as_hash(result, view: :show) }
    )
  end

  def update
    move_timeline_item.update(move_timeline_items_params)

    render_result(
      result: move_timeline_item,
      success: { move_timeline_item: MoveTimelineItemsSerializer.render_as_hash(move_timeline_item, view: :show) }
    )
  end

  def destroy
    move_timeline_item.destroy!
    success_response
  end

  private

  def move_timeline_items_params
    params.permit(
      :deadline, :description, :position, :status, :title,
      notes: []
    )
  end

  def relocation_plan
    @relocation_plan ||= current_user.relocation_plans.find(params[:relocation_plan_id])
  end

  def move_timeline_item
    @move_timeline_item ||= relocation_plan.move_timeline_items.find(params[:move_timeline_item_id])
  end
end
