class Api::V1::CardsController < ApplicationController
  # skip_before_action :authenticate_user!
  before_action :set_flashcard
  before_action :authenticate_api_v1_user!
  before_action :set_card, only: %i[show update destroy]

  def index
    @cards = @flashcard.cards
    render json: @cards
  end

  def show
    render json: @card
  end

  def create
    card = Card.new(card_params)
    card.flashcard = @flashcard
    if card.save
      render json: card
    else
      render json: { errors: card.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @card.update(card_params)
      render json: @card
    else
      render json: { errors: @card.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @card.destroy
    render json: { message: 'This card was successfuly deleted!' }, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'card was not found' }, status: :not_found
  rescue StandardError => e
    render json: { error: e.errors }, status: :unprocessable_entity
  end

  private

  def set_flashcard
    @flashcard = Flashcard.find(params[:flashcard_id])
  end

  def set_card
    @card = @flashcard.cards.find(params[:id])
  end

  def card_params
    params.require(:card).permit(:front, :back, :pronunciation, :front_sentence, :back_sentence, :explanation,
                                 :card_type)
  end
end
