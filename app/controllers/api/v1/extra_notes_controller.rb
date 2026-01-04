class Api::V1::ExtraNotesController < ApplicationController
  # skip_before_action :authenticate_user!
  before_action :set_card
  before_action :set_extra_note, only: %i[update destroy]

  def index
    @extra_notes = @card.extra_notes
    render json: @extra_notes
  end

  # def show
  #   render json: @card
  # end

  def create
    extra_note = ExtraNote.new(extra_note_params)
    extra_note.card = @card
    if extra_note.save
      render json: extra_note
    else
      render json: { errors: extra_note.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @extra_note.update(extra_note_params)
      render json: @extra_note
    else
      render json: { errors: @extra_note.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @extra_note.destroy
    render json: { message: 'This extra_note was successfuly deleted!' }, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'extra_note was not found' }, status: :not_found
  rescue StandardError => e
    render json: { error: e.errors }, status: :unprocessable_entity
  end

  private

  def set_card
    @card = Card.find(params[:card_id])
  end

  def set_extra_note
    @extra_note = @card.extra_notes.find(params[:id])
  end

  def extra_note_params
    params.require(:extra_note).permit(:note_type, :content)
  end
end
