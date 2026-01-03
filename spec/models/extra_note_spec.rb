require 'rails_helper'

RSpec.describe ExtraNote, type: :model do
  describe '#valid?' do
    subject { extra_note }

    let(:extra_note) { FactoryBot.build(:extra_note, attributes) }
    let(:attributes) { {} }

    describe 'content' do
      context '256字の場合' do
        let(:attributes) do
          { content: 'あ' * 256 }
        end

        it { is_expected.to be_valid }
      end

      context '257字の場合' do
        let(:attributes) do
          { content: 'あ' * 257 }
        end

        it {
          expect(subject).to be_invalid
          expect(subject.errors.attribute_names).to contain_exactly(:content)
          expect(subject.errors.full_messages).to contain_exactly(
            '内容は256文字以内で入力してください'
          )
        }
      end

      context 'nilの場合' do
        let(:attributes) do
          { content: nil }
        end

        it {
          expect(subject).to be_invalid
          expect(subject.errors.attribute_names).to contain_exactly(:content)
          expect(subject.errors.full_messages).to contain_exactly(
            '内容を入力してください'
          )
        }
      end

      context '空文字の場合' do
        let(:attributes) do
          { content: "" }
        end

        it {
          expect(subject).to be_invalid
          expect(subject.errors.attribute_names).to contain_exactly(:content)
          expect(subject.errors.full_messages).to contain_exactly(
            '内容を入力してください'
          )
        }
      end

      context '1文字の場合' do
        let(:attributes) do
          { content: "あ" }
        end

        it {
          expect(subject).to be_valid
        }
      end
    end

    describe 'note_type' do
      ExtraNote::NOTE_TYPES.each do |note_type|
        context "値が #{note_type} の場合" do
          let(:attributes) do
            { note_type: note_type }
          end

          it {
            expect(subject).to be_valid
          }
        end
      end

      context '値が noun の場合' do
        let(:attributes) do
          { note_type: "noun" }
        end

        it {
          expect(subject).to be_invalid
          expect(subject.errors.attribute_names).to contain_exactly(:note_type)
          expect(subject.errors.full_messages).to contain_exactly(
            'ノート形式は一覧にありません'
          )
        }
      end

      context 'nilの場合' do
        let(:attributes) do
          { note_type: nil }
        end

        it {
          expect(subject).to be_invalid
          expect(subject.errors.attribute_names).to contain_exactly(:note_type)
          expect(subject.errors.full_messages).to contain_exactly(
            'ノート形式を入力してください'
          )
        }
      end

      context '空文字の場合' do
        let(:attributes) do
          { note_type: "" }
        end

        it {
          expect(subject).to be_invalid
          expect(subject.errors.attribute_names).to contain_exactly(:note_type)
          expect(subject.errors.full_messages).to contain_exactly(
            'ノート形式を入力してください'
          )
        }
      end
    end
  end
end
