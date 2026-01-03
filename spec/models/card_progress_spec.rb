require 'rails_helper'

RSpec.describe CardProgress, type: :model do
  # describe '#valid?' do
  #   subject { card_progress }

  #   let(:card_progress) { FactoryBot.build(:card_progress, attributes) }
  #   let(:attributes) { {} }

  #   describe 'title' do
  #     context '60字の場合' do
  #       let(:attributes) do
  #         { title: 'あ' * 60 }
  #       end

  #       it { is_expected.to be_valid }
  #     end

  #     context '61字の場合' do
  #       let(:attributes) do
  #         { title: 'あ' * 61 }
  #       end

  #       it {
  #         expect(subject).to be_invalid
  #         expect(subject.errors.attribute_names).to contain_exactly(:title)
  #         expect(subject.errors.full_messages).to contain_exactly(
  #           'タイトルは60文字以内で入力してください'
  #         )
  #       }
  #     end

  #     context 'nilの場合' do
  #       let(:attributes) do
  #         { title: nil }
  #       end

  #       it {
  #         expect(subject).to be_invalid
  #         expect(subject.errors.attribute_names).to contain_exactly(:title)
  #         expect(subject.errors.full_messages).to contain_exactly(
  #           'タイトルを入力してください'
  #         )
  #       }
  #     end

  #     context '空文字の場合' do
  #       let(:attributes) do
  #         { title: "" }
  #       end

  #       it {
  #         expect(subject).to be_invalid
  #         expect(subject.errors.attribute_names).to contain_exactly(:title)
  #         expect(subject.errors.full_messages).to contain_exactly(
  #           'タイトルを入力してください'
  #         )
  #       }
  #     end

  #     context '1文字の場合' do
  #       let(:attributes) do
  #         { title: "あ" }
  #       end

  #       it {
  #         expect(subject).to be_valid
  #       }
  #     end
  #   end

  #   describe 'description' do
  #     context '120字の場合' do
  #       let(:attributes) do
  #         { description: 'あ' * 120 }
  #       end

  #       it { is_expected.to be_valid }
  #     end

  #     context '121字の場合' do
  #       let(:attributes) do
  #         { description: 'あ' * 121 }
  #       end

  #       it {
  #         expect(subject).to be_invalid
  #         expect(subject.errors.attribute_names).to contain_exactly(:description)
  #         expect(subject.errors.full_messages).to contain_exactly(
  #           '説明は120文字以内で入力してください'
  #         )
  #       }
  #     end

  #     context 'nilの場合' do
  #       let(:attributes) do
  #         { description: nil }
  #       end

  #       it {
  #         expect(subject).to be_valid
  #       }
  #     end

  #     context '空文字の場合' do
  #       let(:attributes) do
  #         { description: "" }
  #       end

  #       it {
  #         expect(subject).to be_valid
  #       }
  #     end

  #     context '1文字の場合' do
  #       let(:attributes) do
  #         { description: "あ" }
  #       end

  #       it {
  #         expect(subject).to be_valid
  #       }
  #     end
  #   end

  #   describe 'language' do
  #     %w[EN DE FR IT].each do |lang|
  #       context "値が #{lang} の場合" do
  #         let(:attributes) do
  #           { language: lang }
  #         end

  #         it {
  #           expect(subject).to be_valid
  #         }
  #       end
  #     end

  #     context '値が JA の場合' do
  #       let(:attributes) do
  #         { language: "JA" }
  #       end

  #       it {
  #         expect(subject).to be_invalid
  #         expect(subject.errors.attribute_names).to contain_exactly(:language)
  #         expect(subject.errors.full_messages).to contain_exactly(
  #           '言語は一覧にありません'
  #         )
  #       }
  #     end

  #     context 'nilの場合' do
  #       let(:attributes) do
  #         { language: nil }
  #       end

  #       it {
  #         expect(subject).to be_invalid
  #         expect(subject.errors.attribute_names).to contain_exactly(:language)
  #         expect(subject.errors.full_messages).to contain_exactly(
  #           '言語を入力してください', '言語は一覧にありません'
  #         )
  #       }
  #     end

  #     context '空文字の場合' do
  #       let(:attributes) do
  #         { language: "" }
  #       end

  #       it {
  #         expect(subject).to be_invalid
  #         expect(subject.errors.attribute_names).to contain_exactly(:language)
  #         expect(subject.errors.full_messages).to contain_exactly(
  #           '言語を入力してください', '言語は一覧にありません'
  #         )
  #       }
  #     end
  #   end
  # end
end
