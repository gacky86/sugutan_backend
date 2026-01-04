require 'rails_helper'

RSpec.describe "Api::V1::ExtraNotes", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:auth_headers) { user.create_new_auth_token }
  let(:flashcard) { FactoryBot.create(:flashcard, user: user) }
  let(:card) { FactoryBot.create(:card, flashcard: flashcard) }

  # GET /api/v1/cards/:card_id/extra_notes
  describe "GET /api/v1/cards/:card_id/extra_notes" do
    let!(:extra_notes) { FactoryBot.create_list(:extra_note, 2, card: card) }

    it "成功レスポンスとノート一覧を返す" do
      get api_v1_card_extra_notes_path(card), headers: auth_headers

      expect(response).to have_http_status(:success)
      json = response.parsed_body
      expect(json.length).to eq(2)
    end
  end

  # POST /api/v1/cards/:card_id/extra_notes
  describe "POST /api/v1/cards/:card_id/extra_notes" do
    context "有効なパラメータの場合" do
      let(:valid_params) { { extra_note: { note_type: "synonyms", content: "これは補足説明です" } } }

      it "新しいノートを作成する" do
        expect do
          post api_v1_card_extra_notes_path(card), params: valid_params, headers: auth_headers
        end.to change(ExtraNote, :count).by(1)
        expect(response).to have_http_status(:success)
      end
    end

    context "無効なパラメータの場合" do
      # contentが必須バリデーションにあると想定
      let(:invalid_params) { { extra_note: { content: "" } } }

      it "422を返し、配列形式のエラーメッセージを含む" do
        post api_v1_card_extra_notes_path(card), params: invalid_params, headers: auth_headers
        expect(response).to have_http_status(:unprocessable_entity)

        json = response.parsed_body
        # .full_messages を使っているため配列でチェック
        expect(json["errors"]).to include("内容を入力してください")
      end
    end
  end

  # PATCH /api/v1/cards/:card_id/extra_notes/:id
  describe "PATCH /api/v1/cards/:card_id/extra_notes/:id" do
    let!(:extra_note) { FactoryBot.create(:extra_note, card: card, content: "修正前") }

    it "ノートを更新する" do
      patch api_v1_card_extra_note_path(card, extra_note),
            params: { extra_note: { content: "修正後" } },
            headers: auth_headers

      expect(response).to have_http_status(:success)
      expect(extra_note.reload.content).to eq("修正後")
    end
  end

  # DELETE /api/v1/cards/:card_id/extra_notes/:id
  describe "DELETE /api/v1/cards/:card_id/extra_notes/:id" do
    let!(:extra_note) { FactoryBot.create(:extra_note, card: card) }

    it "ノートを削除する" do
      expect do
        delete api_v1_card_extra_note_path(card, extra_note), headers: auth_headers
      end.to change(ExtraNote, :count).by(-1)

      expect(response).to have_http_status(:ok)
      expect(response.parsed_body["message"]).to eq('This extra_note was successfuly deleted!')
    end
  end
end
