# frozen_string_literal: true

class MoveTimelineItemsSerializer < Blueprinter::Base
  identifier :id

  fields :status, :title, :completed_at

  view :index do
    fields :position
  end

  view :show do
    fields :deadline, :description, :notes, :created_at, :updated_at

    field :attachments do |item|
      item.attachments.map do |attachment|
        {
          name: attachment.filename.to_s,
          byte_size: attachment.byte_size,
          content_type: attachment.content_type,
          url: Rails.application.routes.url_helpers.url_for(attachment)
        }
      end
    end
  end
end
