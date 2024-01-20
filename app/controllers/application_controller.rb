class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception, except: [:save_request]
  # before_action :create_word_list_session
  skip_before_action :verify_authenticity_token

  def valid_empty_token?
    render json: { error: ErrorManager.error(:empty_token) }, status: :not_found if token.nil? || token.empty?
  end

  def valid_current_token?
    valid_token = TokenService.valid_token?(token)
    return if valid_token == true
    render json: valid_token, status: :not_found
  end

  def token
    token = @token || params[:token] || request.headers['Authorization']
    token&.sub("Bearer", '')&.strip
  end

  def create_word_list_session
    session[:word_list] ||= []
  end
end
