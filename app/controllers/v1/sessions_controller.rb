# frozen_string_literal: true

class V1::SessionsController < ApplicationController
  allow_unauthenticated_access only: [:create]

  def create
    if (user = User.authenticate_by(session_params))
      start_new_session_for(user)

      user = UsersSerializer.render_as_hash(current_user, view: :general)
      success_response(extra: { user: })
    else
      error_response(errors: 'Invalid email or password', status: :unauthorized)
    end
  end

  def destroy
    terminate_session
    success_response(extra: { message: 'Logged out successfully' })
  end

  private

  def session_params
    params.permit(:email_address, :password)
  end
end
