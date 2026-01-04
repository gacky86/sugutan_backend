class Api::V1::FlashcardsController < ApplicationController
  # skip_before_action :authenticate_user!
  before_action :authenticate_api_v1_user!
  def index
    flashcards = current_api_v1_user.flashcards.with_stats
    render json: flashcards.map { |f|
      {
        id: f.id,
        title: f.title,
        description: f.description,
        language: f.language,
        cards_count: f.cards_count,
        last_reviewed_days_ago: f.last_reviewed_days_ago
      }
    }
  end

  def show
    render json: Flashcard.find(params[:id])
  end

  def create
    flashcard = Flashcard.new(flashcard_params)
    flashcard.user = current_api_v1_user
    if flashcard.save
      render json: flashcard
    else
      render json: { errors: flashcard.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    flashcard = Flashcard.find(params[:id])
    if flashcard.update(flashcard_params)
      render json: flashcard
    else
      render json: { errors: flashcard.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    flashcard = Flashcard.find(params[:id])
    flashcard.destroy
    render json: { message: 'This flashcard was successfuly deleted!' }, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'flashcard was not found' }, status: :not_found
  rescue StandardError => e
    render json: { error: e.errors }, status: :unprocessable_entity
  end

  private

  def flashcard_params
    params.require(:flashcard).permit(:user_id, :title, :description, :language,
                                      :icon_color)
  end
end
