class ApiServiceController < ApplicationController
  before_action :valid_empty_token?, only: [:get_word, :save_request]
  before_action :valid_current_token?, only: [:get_word, :save_request]

  def get_token
    token = TokenService.generate_token

    render json: {
      token: token,
      message: ErrorManager.error(:correct_token)
    }
  end

  def get_word
    return create_key if TokenService.validate_token_time >= 0.2.seconds

    word = WordService.generate_word
    render json: { word: word }
  end

  def save_request
    return render json: { error:  ErrorManager.error(:key_error) } if !validate_key

    request = Request.new(
      save_request_params
    )

    if request.save
      render json: {}, status: :ok
    else
      render json: {error: "#{post.errors.full_messages} "}, status: :error
    end    
  end

  private

  def validate_key
    TokenService.get_key == params[:key]
  end

  def create_key
    TokenService.save_key(WordService.generate_words_key)
    render json: { }, status: :not_found
  end

  def save_request_params
    params.permit(:name, :email, :key, :source)
  end
end