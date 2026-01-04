require 'rails_helper'

RSpec.describe Flashcard, type: :model do
  describe '#valid?' do
    subject { flashcard }

    let(:flashcard) { FactoryBot.build(:flashcard, attributes) }
    let(:attributes) { {} }

    describe 'title' do
      context '60字の場合' do
        let(:attributes) do
          { title: 'あ' * 60 }
        end

        it { is_expected.to be_valid }
      end

      context '61字の場合' do
        let(:attributes) do
          { title: 'あ' * 61 }
        end

        it {
          expect(subject).to be_invalid
          expect(subject.errors.attribute_names).to contain_exactly(:title)
          expect(subject.errors.full_messages).to contain_exactly(
            'タイトルは60文字以内で入力してください'
          )
        }
      end

      context 'nilの場合' do
        let(:attributes) do
          { title: nil }
        end

        it {
          expect(subject).to be_invalid
          expect(subject.errors.attribute_names).to contain_exactly(:title)
          expect(subject.errors.full_messages).to contain_exactly(
            'タイトルを入力してください'
          )
        }
      end

      context '空文字の場合' do
        let(:attributes) do
          { title: "" }
        end

        it {
          expect(subject).to be_invalid
          expect(subject.errors.attribute_names).to contain_exactly(:title)
          expect(subject.errors.full_messages).to contain_exactly(
            'タイトルを入力してください'
          )
        }
      end

      context '1文字の場合' do
        let(:attributes) do
          { title: "あ" }
        end

        it {
          expect(subject).to be_valid
        }
      end
    end

    describe 'description' do
      context '120字の場合' do
        let(:attributes) do
          { description: 'あ' * 120 }
        end

        it { is_expected.to be_valid }
      end

      context '121字の場合' do
        let(:attributes) do
          { description: 'あ' * 121 }
        end

        it {
          expect(subject).to be_invalid
          expect(subject.errors.attribute_names).to contain_exactly(:description)
          expect(subject.errors.full_messages).to contain_exactly(
            '説明は120文字以内で入力してください'
          )
        }
      end

      context 'nilの場合' do
        let(:attributes) do
          { description: nil }
        end

        it {
          expect(subject).to be_valid
        }
      end

      context '空文字の場合' do
        let(:attributes) do
          { description: "" }
        end

        it {
          expect(subject).to be_valid
        }
      end

      context '1文字の場合' do
        let(:attributes) do
          { description: "あ" }
        end

        it {
          expect(subject).to be_valid
        }
      end
    end

    describe 'language' do
      Flashcard::LANGUAGE.each do |lang|
        context "値が #{lang} の場合" do
          let(:attributes) do
            { language: lang }
          end

          it {
            expect(subject).to be_valid
          }
        end
      end

      context '値が JA の場合' do
        let(:attributes) do
          { language: "JA" }
        end

        it {
          expect(subject).to be_invalid
          expect(subject.errors.attribute_names).to contain_exactly(:language)
          expect(subject.errors.full_messages).to contain_exactly(
            '言語は一覧にありません'
          )
        }
      end

      context 'nilの場合' do
        let(:attributes) do
          { language: nil }
        end

        it {
          expect(subject).to be_invalid
          expect(subject.errors.attribute_names).to contain_exactly(:language)
          expect(subject.errors.full_messages).to contain_exactly(
            '言語を入力してください'
          )
        }
      end

      context '空文字の場合' do
        let(:attributes) do
          { language: "" }
        end

        it {
          expect(subject).to be_invalid
          expect(subject.errors.attribute_names).to contain_exactly(:language)
          expect(subject.errors.full_messages).to contain_exactly(
            '言語を入力してください'
          )
        }
      end
    end
  end

  describe '統計情報に関するテスト' do
    let(:user) { FactoryBot.create(:user) }
    let(:flashcard) { FactoryBot.create(:flashcard, user: user) }
    let(:card1) { FactoryBot.create(:card, flashcard: flashcard) }
    let(:card2) { FactoryBot.create(:card, flashcard: flashcard) }

    describe '.with_stats' do
      subject { Flashcard.with_stats.find(flashcard.id) }

      before do
        # 1つ目のカードに学習記録（3日前）を作成
        FactoryBot.create(:card_progress, card: card1, last_reviewed_at: 3.days.ago)
        # 2つ目のカードに学習記録（1日前）を作成
        FactoryBot.create(:card_progress, card: card2, last_reviewed_at: 1.day.ago)
      end

      it 'cards_countが正しく計算されること' do
        expect(subject.cards_count).to eq(2)
      end

      it '最新のlast_reviewed_atが取得できること' do
        # 1日前の方が新しいため、card2の学習日が採用される
        expect(subject.last_reviewed_at.to_date).to eq(1.day.ago.to_date)
      end

      it 'カードが存在しない場合でもcards_countが0として取得できること' do
        empty_flashcard = FactoryBot.create(:flashcard, user: user)
        stats = Flashcard.with_stats.find(empty_flashcard.id)
        expect(stats.cards_count).to eq(0)
        expect(stats.last_reviewed_at).to be_nil
      end
    end

    # describe '#last_reviewed_days_ago' do
    #   context 'last_reviewed_atが存在する場合' do
    #     it '今日との日数差が正しく計算されること' do
    #       # with_statsを使わずに、手動で属性をセットしてテストすることも可能
    #       flashcard_with_attr = Flashcard.new
    #       allow(flashcard_with_attr).to receive(:last_reviewed_at).and_return(3.days.ago)

    #       expect(flashcard_with_attr.last_reviewed_days_ago).to eq(3)
    #     end
    #   end

    #   context 'last_reviewed_atが今日の場合' do
    #     it '0を返すこと' do
    #       allow(flashcard).to receive(:last_reviewed_at).and_return(Time.current)
    #       expect(flashcard.last_reviewed_days_ago).to eq(0)
    #     end
    #   end

    #   context 'last_reviewed_atがnilの場合' do
    #     it 'nilを返すこと' do
    #       expect(flashcard.last_reviewed_at).to be_nil # 通常の状態
    #       expect(flashcard.last_reviewed_days_ago).to be_nil
    #     end
    #   end
    # end
  end
end
