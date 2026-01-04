require 'rails_helper'

RSpec.describe CardProgress, type: :model do
  describe '#valid?' do
    subject { card_progress }

    let(:user) { FactoryBot.create(:user) }
    let(:card) { FactoryBot.create(:card) }
    let(:card_progress) { FactoryBot.build(:card_progress, user: user, card: card, mode: :input) }
    let(:attributes) { {} }

    describe '存在性のチェック' do
      it { is_expected.to be_valid }

      %i[interval_days next_review_at review_count mode].each do |attr|
        it "#{attr}が空の場合は無効であること" do
          card_progress.send(:"#{attr}=", nil)
          expect(card_progress).to be_invalid
          expect(card_progress.errors.attribute_names).to include(attr)
        end
      end
    end

    describe 'Uniqueness (card_id, user_id, mode の組み合わせ)' do
      before { card_progress.save! }

      context '同じユーザー、同じカード、同じモードのレコードを作ろうとした場合' do
        let(:duplicate_progress) { FactoryBot.build(:card_progress, user: user, card: card, mode: :input) }

        it '無効であること' do
          expect(duplicate_progress).to be_invalid
          expect(duplicate_progress.errors.attribute_names).to include(:card_id)
        end
      end

      context '同じユーザー、同じカードでも、モード(mode)が異なる場合' do
        let(:other_mode_progress) { FactoryBot.build(:card_progress, user: user, card: card, mode: :output) }

        it '有効であること' do
          expect(other_mode_progress).to be_valid
        end
      end

      context '同じカード、同じモードでも、ユーザー(user_id)が異なる場合' do
        let(:other_user) { FactoryBot.create(:user) }
        let(:other_user_progress) { FactoryBot.build(:card_progress, user: other_user, card: card, mode: :input) }

        it '有効であること' do
          expect(other_user_progress).to be_valid
        end
      end
    end

    describe 'mode (enum)' do
      it 'inputとoutputのみ許可されること' do
        expect { card_progress.mode = "other" }.to raise_error(ArgumentError)
        expect { card_progress.mode = :input }.not_to raise_error
        expect { card_progress.mode = :output }.not_to raise_error
      end
    end
  end

  describe 'メソッド' do
    let(:user) { FactoryBot.create(:user) }
    let(:card) { FactoryBot.create(:card) }
    let(:progress) do
      FactoryBot.create(:card_progress, user: user, card: card, mode: :input, review_count: 0, easiness_factor: 2.5,
                                        interval_days: 0)
    end

    describe '#mark_review!' do
      context '不正な難易度が渡された場合' do
        it 'ArgumentErrorが発生すること' do
          expect { progress.mark_review!(difficulty: 'unknown') }.to raise_error(ArgumentError, "invalid difficulty")
        end
      end

      context '難易度が "again" (quality < 3) の場合' do
        it 'reset_progress! が呼ばれること' do
          # メソッドが呼ばれたことを検証
          expect(progress).to receive(:reset_progress!)
          progress.mark_review!(difficulty: 'again')
        end
      end

      context '難易度が "easy" (quality >= 3) の場合' do
        it 'advance_progress! が呼ばれること' do
          expect(progress).to receive(:advance_progress!).with(5) # easyはquality=5
          progress.mark_review!(difficulty: 'easy')
        end
      end
    end

    describe '#reset_progress!' do
      it '進捗が初期状態にリセットされること' do
        progress.update!(interval_days: 10, review_count: 5)

        progress.reset_progress!

        expect(progress.interval_days).to eq(1)
        expect(progress.next_review_at.to_date).to eq(Date.tomorrow)
        expect(progress.last_reviewed_at).to be_within(1.second).of(Time.current)
      end
    end

    describe '#advance_progress!' do
      context '初めての学習 (review_count: 0) の場合' do
        it '次の復習間隔が1日になること' do
          progress.advance_progress!(4) # normal
          expect(progress.interval_days).to eq(1)
          expect(progress.review_count).to eq(1)
        end
      end

      context '2回目の学習 (review_count: 1) の場合' do
        it '次の復習間隔が6日になること' do
          progress.update!(review_count: 1)
          progress.advance_progress!(4)
          expect(progress.interval_days).to eq(6)
          expect(progress.review_count).to eq(2)
        end
      end

      context '3回目以降の学習の場合' do
        it 'easiness_factor に基づいて間隔が計算されること' do
          # 既にある程度学習が進んでいる状態を作る
          progress.update!(review_count: 2, interval_days: 6, easiness_factor: 2.5)

          # quality 5 (easy) の場合、EFは増加する
          # new_ef = 2.5 + (0.1 - (0 * ...)) = 2.6
          # new_interval = (6 * 2.6).round = 16
          progress.advance_progress!(5)

          expect(progress.easiness_factor).to be > 2.5
          expect(progress.interval_days).to eq(16)
          expect(progress.next_review_at.to_date).to eq(16.days.from_now.to_date)
        end
      end
    end
  end

  describe 'スコープ' do
    let!(:due_progress) { FactoryBot.create(:card_progress, next_review_at: 1.day.ago) }
    let!(:future_progress) { FactoryBot.create(:card_progress, next_review_at: 1.day.from_now) }

    describe '.due' do
      it '復習期限が現在時刻以前のレコードのみを取得すること' do
        expect(CardProgress.due).to include(due_progress)
        expect(CardProgress.due).not_to include(future_progress)
      end
    end
  end
end
