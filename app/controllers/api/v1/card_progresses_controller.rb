class Api::V1::CardProgressesController < ApplicationController
  before_action :authenticate_user!

  # 学習記録の初期化：単語帳が持つカードに対してprogressがなければ作成、あれば取得
  def start_learning
    flashcard = current_user.flashcards.find(params[:flashcard_id])
    flashcard.cards.each do |card|
      CardProgressInitializer.call(
        user: current_user,
        card: card
      )
    end
    render json: { message: 'cards in this flashcard were initialized' }, status: :ok
  end

  # 学習対象カードの取得：本日学習対象となるカードの取得
  def due_cards
    progresses = current_user.card_progresses.due.ordered_by_due.includes(:card)
    render json: progresses
  end

  # カード学習記録：ユーザーがカードに対して感じた難易度(difficulty)に基づいてprogressを更新
  def review
    progress = current_user.card_progresses.find(params[:id])

    progress.mark_review!(difficulty: params[:difficulty])

    render json: progress
  end
end
