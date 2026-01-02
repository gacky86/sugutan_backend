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

        it { is_expected.to be_invalid }
      end
    end
  end
  # pending "add some examples to (or delete) #{__FILE__}"
end
