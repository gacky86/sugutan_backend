class Api::V1::Gemini::DictionaryController < ApplicationController
  def index
    word = params[:text]

    result = Gemini::DictionaryService.call(word)

    render json: result, status: :ok
  rescue StandardError => e
    Rails.logger.error(e.message)
    render json: { error: e.message }, status: :internal_server_error
  end
end
