require 'rails_helper'

RSpec.describe Card, type: :model do
  describe '#valid?' do
    subject { card }

    let(:card) { FactoryBot.build(:card, attributes) }
    let(:attributes) { {} }

    describe 'front' do
      context '60字の場合' do
        let(:attributes) do
          { front: 'あ' * 60 }
        end

        it { is_expected.to be_valid }
      end

      context '61字の場合' do
        let(:attributes) do
          { front: 'あ' * 61 }
        end

        it {
          expect(subject).to be_invalid
          expect(subject.errors.attribute_names).to contain_exactly(:front)
          expect(subject.errors.full_messages).to contain_exactly(
            '表面（単語）は60文字以内で入力してください'
          )
        }
      end

      context 'nilの場合' do
        let(:attributes) do
          { front: nil }
        end

        it {
          expect(subject).to be_invalid
          expect(subject.errors.attribute_names).to contain_exactly(:front)
          expect(subject.errors.full_messages).to contain_exactly(
            '表面（単語）を入力してください'
          )
        }
      end

      context '空文字の場合' do
        let(:attributes) do
          { front: "" }
        end

        it {
          expect(subject).to be_invalid
          expect(subject.errors.attribute_names).to contain_exactly(:front)
          expect(subject.errors.full_messages).to contain_exactly(
            '表面（単語）を入力してください'
          )
        }
      end

      context '1文字の場合' do
        let(:attributes) do
          { front: "あ" }
        end

        it {
          expect(subject).to be_valid
        }
      end
    end

    describe 'back' do
      context '60字の場合' do
        let(:attributes) do
          { back: 'a' * 60 }
        end

        it { is_expected.to be_valid }
      end

      context '61字の場合' do
        let(:attributes) do
          { back: 'a' * 61 }
        end

        it {
          expect(subject).to be_invalid
          expect(subject.errors.attribute_names).to contain_exactly(:back)
          expect(subject.errors.full_messages).to contain_exactly(
            '裏面（単語）は60文字以内で入力してください'
          )
        }
      end

      context 'nilの場合' do
        let(:attributes) do
          { back: nil }
        end

        it {
          expect(subject).to be_invalid
          expect(subject.errors.attribute_names).to contain_exactly(:back)
          expect(subject.errors.full_messages).to contain_exactly(
            '裏面（単語）を入力してください'
          )
        }
      end

      context '空文字の場合' do
        let(:attributes) do
          { back: "" }
        end

        it {
          expect(subject).to be_invalid
          expect(subject.errors.attribute_names).to contain_exactly(:back)
          expect(subject.errors.full_messages).to contain_exactly(
            '裏面（単語）を入力してください'
          )
        }
      end

      context '1文字の場合' do
        let(:attributes) do
          { back: "a" }
        end

        it {
          expect(subject).to be_valid
        }
      end
    end

    describe 'front_sentence' do
      context '256字の場合' do
        let(:attributes) do
          { front_sentence: 'あ' * 256 }
        end

        it { is_expected.to be_valid }
      end

      context '257字の場合' do
        let(:attributes) do
          { front_sentence: 'あ' * 257 }
        end

        it {
          expect(subject).to be_invalid
          expect(subject.errors.attribute_names).to contain_exactly(:front_sentence)
          expect(subject.errors.full_messages).to contain_exactly(
            '表面（例文）は256文字以内で入力してください'
          )
        }
      end

      context 'nilの場合' do
        let(:attributes) do
          { front_sentence: nil }
        end

        it {
          expect(subject).to be_invalid
          expect(subject.errors.attribute_names).to contain_exactly(:front_sentence)
          expect(subject.errors.full_messages).to contain_exactly(
            '表面（例文）を入力してください'
          )
        }
      end

      context '空文字の場合' do
        let(:attributes) do
          { front_sentence: "" }
        end

        it {
          expect(subject).to be_invalid
          expect(subject.errors.attribute_names).to contain_exactly(:front_sentence)
          expect(subject.errors.full_messages).to contain_exactly(
            '表面（例文）を入力してください'
          )
        }
      end

      context '1文字の場合' do
        let(:attributes) do
          { front_sentence: "あ" }
        end

        it { is_expected.to be_valid }
      end
    end

    describe 'back_sentence' do
      context '256字の場合' do
        let(:attributes) do
          { back_sentence: 'a' * 256 }
        end

        it { is_expected.to be_valid }
      end

      context '257字の場合' do
        let(:attributes) do
          { back_sentence: 'a' * 257 }
        end

        it {
          expect(subject).to be_invalid
          expect(subject.errors.attribute_names).to contain_exactly(:back_sentence)
          expect(subject.errors.full_messages).to contain_exactly(
            '裏面（例文）は256文字以内で入力してください'
          )
        }
      end

      context 'nilの場合' do
        let(:attributes) do
          { back_sentence: nil }
        end

        it {
          expect(subject).to be_invalid
          expect(subject.errors.attribute_names).to contain_exactly(:back_sentence)
          expect(subject.errors.full_messages).to contain_exactly(
            '裏面（例文）を入力してください'
          )
        }
      end

      context '空文字の場合' do
        let(:attributes) do
          { back_sentence: "" }
        end

        it {
          expect(subject).to be_invalid
          expect(subject.errors.attribute_names).to contain_exactly(:back_sentence)
          expect(subject.errors.full_messages).to contain_exactly(
            '裏面（例文）を入力してください'
          )
        }
      end

      context '1文字の場合' do
        let(:attributes) do
          { back_sentence: "a" }
        end

        it { is_expected.to be_valid }
      end
    end

    describe 'explanation_front' do
      context '256字の場合' do
        let(:attributes) do
          { explanation_front: 'a' * 256 }
        end

        it { is_expected.to be_valid }
      end

      context '257字の場合' do
        let(:attributes) do
          { explanation_front: 'a' * 257 }
        end

        it {
          expect(subject).to be_invalid
          expect(subject.errors.attribute_names).to contain_exactly(:explanation_front)
          expect(subject.errors.full_messages).to contain_exactly(
            '表面（解説）は256文字以内で入力してください'
          )
        }
      end

      context 'nilの場合' do
        let(:attributes) do
          { explanation_front: nil }
        end

        it { is_expected.to be_valid }
      end

      context '空文字の場合' do
        let(:attributes) do
          { explanation_front: "" }
        end

        it { is_expected.to be_valid }
      end

      context '1文字の場合' do
        let(:attributes) do
          { explanation_front: "a" }
        end

        it { is_expected.to be_valid }
      end
    end

    describe 'explanation_back' do
      context '256字の場合' do
        let(:attributes) do
          { explanation_back: 'a' * 256 }
        end

        it { is_expected.to be_valid }
      end

      context '257字の場合' do
        let(:attributes) do
          { explanation_back: 'a' * 257 }
        end

        it {
          expect(subject).to be_invalid
          expect(subject.errors.attribute_names).to contain_exactly(:explanation_back)
          expect(subject.errors.full_messages).to contain_exactly(
            '裏面（解説）は256文字以内で入力してください'
          )
        }
      end

      context 'nilの場合' do
        let(:attributes) do
          { explanation_back: nil }
        end

        it { is_expected.to be_valid }
      end

      context '空文字の場合' do
        let(:attributes) do
          { explanation_back: "" }
        end

        it { is_expected.to be_valid }
      end

      context '1文字の場合' do
        let(:attributes) do
          { explanation_back: "a" }
        end

        it { is_expected.to be_valid }
      end
    end

    describe 'card_type' do
      Card::CARD_TYPES.each do |card_type|
        context "値が #{card_type} の場合" do
          let(:attributes) do
            { card_type: card_type }
          end

          it {
            expect(subject).to be_valid
          }
        end
      end

      context '値が synonyms の場合' do
        let(:attributes) do
          { card_type: "synonyms" }
        end

        it {
          expect(subject).to be_invalid
          expect(subject.errors.attribute_names).to contain_exactly(:card_type)
          expect(subject.errors.full_messages).to contain_exactly(
            '品詞は一覧にありません'
          )
        }
      end

      context 'nilの場合' do
        let(:attributes) do
          { card_type: nil }
        end

        it {
          expect(subject).to be_invalid
          expect(subject.errors.attribute_names).to contain_exactly(:card_type)
          expect(subject.errors.full_messages).to contain_exactly(
            '品詞を入力してください'
          )
        }
      end

      context '空文字の場合' do
        let(:attributes) do
          { card_type: "" }
        end

        it {
          expect(subject).to be_invalid
          expect(subject.errors.attribute_names).to contain_exactly(:card_type)
          expect(subject.errors.full_messages).to contain_exactly(
            '品詞を入力してください'
          )
        }
      end
    end
  end
end
