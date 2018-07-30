class SessionsController < ApplicationController
  skip_before_action :require_authenticated_user, only: %i[new create]

  def new
  end

  def create
    user = User.find_or_create_from_pw_oauth(oauth_hash)
    sign_in(user)
    redirect_to root_path
  end

  def destroy
    sign_out
    redirect_to new_session_path
  end

  private

  def oauth_hash
    request.env['omniauth.auth']
  end
end
