# frozen_string_literal: true

# == Schema Information
#
# Table name: move_timeline_items
#
#  id                 :bigint           not null, primary key
#  completed_at       :datetime
#  deadline           :datetime
#  description        :text
#  notes              :string           default([]), is an Array
#  position           :integer          not null
#  status             :integer          default("upcoming"), not null
#  title              :string           not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  relocation_plan_id :bigint           not null
#
# Indexes
#
#  index_move_timeline_items_on_relocation_plan_id               (relocation_plan_id)
#  index_move_timeline_items_on_relocation_plan_id_and_position  (relocation_plan_id,position) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (relocation_plan_id => relocation_plans.id)
#
class MoveTimelineItem < ApplicationRecord
  belongs_to :relocation_plan
  has_many_attached :attachments

  enum :status, { upcoming: 0, in_progress: 1, completed: 2, skipped: 3 }

  validates :title, presence: true, length: { in: 3..30 }
  validates :position, presence: true, uniqueness: { scope: :relocation_plan_id }
  validate :previous_items_completed, if: -> { status_changed? && (completed? || skipped?) }

  before_save :set_completed_at, if: :status_changed?

  private

  def set_completed_at
    self.completed_at = completed? ? Time.current : nil
  end

  def previous_items_completed
    return if relocation_plan.move_timeline_items
                             .where(position: ...position)
                             .where.not(status: %i[completed skipped])
                             .none?

    errors.add(:status, 'Complete or skip previous steps first')
  end
end
