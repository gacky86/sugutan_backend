# app/controllers/api/gemini_controller.rb
module Api
  module V1
    class GeminiController < ApplicationController
      # protect_from_forgery with: :null_session # API用にCSRF無効化（必要に応じて）

      def generate_sentence
        service = Gemini::Flash::GenerateContent::Sentence.new(
          system_instruction: params[:system_instruction],
          text: params[:text]
        )
        result = service.run
        render json: { result: result }
      rescue StandardError => e
        render json: { error: e.message }, status: :unprocessable_entity
      end
    end
  end
end
