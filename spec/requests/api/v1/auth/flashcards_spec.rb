require 'rails_helper'

RSpec.describe "Api::V1::Flashcards", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:auth_headers) { user.create_new_auth_token }

  # GET /index
  describe "GET /api/v1/flashcards" do
    let!(:flashcards) { FactoryBot.create_list(:flashcard, 3, user: user) }

    it "成功レスポンスとフラッシュカード一覧を返す" do
      get api_v1_flashcards_path, headers: auth_headers
      expect(response).to have_http_status(:success)
      json = response.parsed_body
      expect(json.length).to eq(3)
      expect(json[0].keys).to include("id", "title", "description", "language", "cards_count", "last_reviewed_days_ago")
    end
  end

  # GET /show
  describe "GET /api/v1/flashcards/:id" do
    let!(:flashcard) { FactoryBot.create(:flashcard, user: user) }

    it "指定したフラッシュカードを返す" do
      get api_v1_flashcard_path(flashcard), headers: auth_headers
      expect(response).to have_http_status(:success)
      json = response.parsed_body
      expect(json["id"]).to eq(flashcard.id)
      expect(json["title"]).to eq(flashcard.title)
    end
  end

  # POST /create
  describe "POST /api/v1/flashcards" do
    context "有効なパラメータの場合" do
      let(:valid_params) { { flashcard: { title: "新しい単語帳", language: "EN", icon_color: "blue" } } }

      it "新しいフラッシュカードを作成する" do
        expect do
          post api_v1_flashcards_path, params: valid_params, headers: auth_headers
        end.to change(Flashcard, :count).by(1)
        expect(response).to have_http_status(:success)
      end
    end

    context "無効なパラメータの場合" do
      let(:invalid_params) { { flashcard: { title: "", language: "JA", icon_color: "" } } }

      it "422を返し、エラーメッセージを含む" do
        post api_v1_flashcards_path, params: invalid_params, headers: auth_headers
        expect(response).to have_http_status(:unprocessable_entity)
        json = response.parsed_body
        expect(json["errors"]).to include("タイトルを入力してください", "言語は一覧にありません", "アイコンカラーを入力してください")
      end
    end
  end

  # PATCH/PUT /update
  describe "PATCH /api/v1/flashcards/:id" do
    let!(:flashcard) { FactoryBot.create(:flashcard, user: user, title: "古いタイトル") }

    context "有効なパラメータの場合" do
      it "フラッシュカードを更新する" do
        patch api_v1_flashcard_path(flashcard), params: { flashcard: { title: "新しいタイトル" } }, headers: auth_headers
        expect(response).to have_http_status(:success)
        expect(flashcard.reload.title).to eq("新しいタイトル")
      end
    end

    context "無効なパラメータの場合" do
      it "422を返す" do
        patch api_v1_flashcard_path(flashcard), params: { flashcard: { title: "" } }, headers: auth_headers
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.parsed_body["errors"]).to include("タイトルを入力してください")
      end
    end
  end

  # DELETE /destroy
  describe "DELETE /api/v1/flashcards/:id" do
    let!(:flashcard) { FactoryBot.create(:flashcard, user: user) }

    it "フラッシュカードを削除する" do
      expect do
        delete api_v1_flashcard_path(flashcard), headers: auth_headers
      end.to change(Flashcard, :count).by(-1)
      expect(response).to have_http_status(:ok)
      expect(response.parsed_body["message"]).to eq('This flashcard was successfuly deleted!')
    end
  end
end
