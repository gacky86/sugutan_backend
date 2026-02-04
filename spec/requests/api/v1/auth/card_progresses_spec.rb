require 'rails_helper'

RSpec.describe "Api::V1::CardProgresses", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:auth_headers) { user.create_new_auth_token }
  let(:flashcard) { FactoryBot.create(:flashcard, user: user) }
  let!(:cards) { FactoryBot.create_list(:card, 3, flashcard: flashcard) }

  # 1. start_learning (初期化処理)
  describe "POST /api/v1/card_progresses/start_learning" do
    let(:params) { { flashcard_id: flashcard.id, mode: 'input' } }

    it "指定した単語帳のカードに対して学習記録が初期化されること" do
      # 実行前のCardProgressの数を確認
      # カード数(3)分だけ増えることを期待
      expect do
        post "/api/v1/card_progresses/start_learning", params: params, headers: auth_headers
      end.to change(CardProgress, :count).by(3)
      expect(response).to have_http_status(:ok)
      expect(response.parsed_body["message"]).to eq('cards in this flashcard were initialized')
    end
  end

  # 2. due (学習対象の取得)
  describe "GET /api/v1/card_progresses/due" do
    let(:params) { { flashcard_id: flashcard.id, mode: 'input' } }

    before do
      # テスト用の学習記録を作成（本日が期限切れの状態を作る）
      cards.each do |card|
        FactoryBot.create(:card_progress, user: user, card: card, mode: 'input', next_review_at: 1.day.ago)
      end
    end

    it "学習対象のカードを正しい構造で返すこと" do
      get "/api/v1/card_progresses/due", params: params, headers: auth_headers

      expect(response).to have_http_status(:success)
      json = response.parsed_body
      expect(json.length).to eq(3)
      # card と extra_notes が含まれているか確認
      expect(json[0]).to include("card")
      expect(json[0]["card"]).to include("extra_notes")
    end
  end

  # 3. review (難易度に応じた更新)
  describe "POST /api/v1/card_progresses/:id/review" do
    let(:progress) { FactoryBot.create(:card_progress, user: user, card: cards.first, mode: 'input') }

    it "学習記録が更新されること" do
      # difficultyを送って、mark_review!が呼ばれることを期待
      post "/api/v1/card_progresses/#{progress.id}/review", params: { difficulty: 'easy' }, headers: auth_headers

      expect(response).to have_http_status(:success)
      # reloadしてDB側で last_reviewed_at 等が更新されたかチェック
      expect(progress.reload.last_reviewed_at).not_to be_nil
    end
  end
end
