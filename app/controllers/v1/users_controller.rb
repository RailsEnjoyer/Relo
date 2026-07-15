# frozen_string_literal: true

class V1::UsersController < ApplicationController
  allow_unauthenticated_access only: [:create]

  def create
    service = Users::Create.call(user_params)
    return error_response(errors: service.errors) if service.failure?

    success_response(extra: service.result)
  end

  def update
    if current_user.update(user_params)
      success_response(extra: { user: UsersSerializer.render_as_hash(current_user, view: :general) })
    else
      error_response(errors: current_user.errors.full_messages)
    end
  end

  private

  def user_params
    params.expect(user: %i[email_address password password_confirmation city_id state_id])
  end
end
