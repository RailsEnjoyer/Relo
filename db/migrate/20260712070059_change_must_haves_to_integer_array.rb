# frozen_string_literal: true

class ChangeMustHavesToIntegerArray < ActiveRecord::Migration[8.1]
  def up
    change_table :relocation_plans, bulk: true do |t|
      t.remove :must_haves
      t.remove :deal_breakers
      t.integer :must_haves, array: true, default: [], null: false
      t.integer :deal_breakers, array: true, default: [], null: false
    end
  end

  def down
    change_table :relocation_plans, bulk: true do |t|
      t.remove :must_haves
      t.remove :deal_breakers
      t.string :must_haves, array: true, default: []
      t.string :deal_breakers, array: true, default: []
    end
  end
end
