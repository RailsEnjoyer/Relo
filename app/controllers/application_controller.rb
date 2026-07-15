# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Authentication
  include Pagy::Method

  allow_browser versions: :modern
  skip_before_action :verify_authenticity_token, raise: false

  stale_when_importmap_changes

  private

  def error_response(errors:, status: :unprocessable_content, extra: nil)
    render json: { status: 'error', errors:, extra: }, status:
  end

  def success_response(status: :ok, extra: nil)
    render json: { status: 'success', extra: }, status:
  end

  def default_meta(pagy_obj)
    {
      current_page: pagy_obj.page,
      total_pages: pagy_obj.pages,
      total_count: pagy_obj.count
    }
  end

  def current_user
    Current.session&.user
  end

  def render_result(result:, success: nil, failure: nil)
    return success_response(extra: success) if result.persisted? && result.errors.none?

    error_response(errors: result.errors)
  end
end
