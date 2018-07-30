class ApplicationController < ActionController::Base
  # Omniauth's provider configuration is done in config/initializers/omniauth.rb

  # Protect resources from unauthenticated access
  before_action :require_authenticated_user

  helper_method :current_user, :passaporte_web_bar

  def current_user
    user_id = session[:current_user_id]
    @current_user ||= User.find(user_id) if user_id.present?
  end

  def sign_in(user)
    session[:current_user_id] = user.id
    @current_user = user
  end

  def sign_out
    session[:current_user_id] = nil
    @current_user = nil
  end

  def signed_in?
    current_user.present?
  end

  def passaporte_web_bar
    connection = Faraday.new(url: ENV['PASSAPORTE_WEB_URL'])
    response = connection.get('/api/v1/widgets/navbar.js') do |request|
      request.headers['Authorization'] = "Bearer #{current_user.token}" if signed_in?
    end
    render inline: response.body
  end

  private

  def require_authenticated_user
    redirect_to new_session_path unless signed_in?
  end
end
