require 'rails_helper'

RSpec.describe "Api::V1::Cards", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:auth_headers) { user.create_new_auth_token }
  let(:flashcard) { FactoryBot.create(:flashcard, user: user) }

  # GET /api/v1/flashcards/:flashcard_id/cards
  describe "GET /api/v1/flashcards/:flashcard_id/cards" do
    let!(:cards) { FactoryBot.create_list(:card, 3, flashcard: flashcard) }

    it "成功レスポンスとカード一覧を返す" do
      get "/api/v1/flashcards/#{flashcard.id}/cards", headers: auth_headers

      expect(response).to have_http_status(:success)
      json = response.parsed_body
      expect(json.length).to eq(3)
    end
  end

  # POST /api/v1/flashcards/:flashcard_id/cards
  describe "POST /api/v1/flashcards/:flashcard_id/cards" do
    context "有効なパラメータの場合" do
      let(:valid_params) do
        { card: { front: "りんご", back: "apple", front_sentence: "私はりんごを食べました。", back_sentence: "I ate an apple.",
                  card_type: "noun" } }
      end

      it "新しいカードを作成する" do
        expect do
          post api_v1_flashcard_cards_path(flashcard), params: valid_params, headers: auth_headers
        end.to change(Card, :count).by(1)
        expect(response).to have_http_status(:success)
      end
    end

    context "無効なパラメータの場合" do
      let(:invalid_params) { { card: { front: "", back: "" } } }

      it "422を返し、ハッシュ形式のエラーを含む" do
        post api_v1_flashcard_cards_path(flashcard), params: invalid_params, headers: auth_headers
        expect(response).to have_http_status(:unprocessable_entity)

        json = response.parsed_body
        expect(json["errors"]).to include("表面（単語）を入力してください", "裏面（単語）を入力してください")
      end
    end
  end

  # PATCH /api/v1/flashcards/:flashcard_id/cards/:id
  describe "PATCH /api/v1/flashcards/:flashcard_id/cards/:id" do
    let!(:card) { FactoryBot.create(:card, flashcard: flashcard, front: "旧テキスト") }

    it "カードを更新する" do
      patch api_v1_flashcard_card_path(flashcard, card), params: { card: { front: "新テキスト" } }, headers: auth_headers
      expect(response).to have_http_status(:success)
      expect(card.reload.front).to eq("新テキスト")
    end
  end

  # DELETE /api/v1/flashcards/:flashcard_id/cards/:id
  describe "DELETE /api/v1/flashcards/:flashcard_id/cards/:id" do
    let!(:card) { FactoryBot.create(:card, flashcard: flashcard) }

    it "カードを削除する" do
      expect do
        delete api_v1_flashcard_card_path(flashcard, card), headers: auth_headers
      end.to change(Card, :count).by(-1)
      expect(response).to have_http_status(:ok)
      expect(response.parsed_body["message"]).to eq('This card was successfuly deleted!')
    end
  end
end
