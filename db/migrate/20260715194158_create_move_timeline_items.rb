# frozen_string_literal: true

class CreateMoveTimelineItems < ActiveRecord::Migration[8.1]
  def change
    create_table :move_timeline_items do |t|
      t.references :relocation_plan, null: false, foreign_key: true
      t.string :title, null: false
      t.text :description
      t.string :notes, array: true, default: []
      t.integer :status, null: false, default: 0
      t.datetime :deadline
      t.datetime :completed_at
      t.integer :position, null: false

      t.index %i[relocation_plan_id position], unique: true

      t.timestamps
    end
  end
end
