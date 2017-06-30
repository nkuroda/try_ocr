require 'spec_helper'

describe TryOcr::Receipt do
  let(:receipt) { TryOcr::Receipt.new(source) }

  describe '#full_text' do
    subject { receipt.full_text }

    context 'when first image' do
      let(:source) { "#{RSPEC_ROOT}/fixtures/files/first_image.png" }

      it { is_expected.to eq '日本語' }
    end

    context 'when second image' do
      let(:source) { "#{RSPEC_ROOT}/fixtures/files/second_image.png" }

      it { is_expected.to eq '領収書毎度ありがとうございます様[証紙切手引受]第一種定形界で規格内)23.00¥120@120小計第一種定形外(規格内)¥12067.0g¥140@140特殊取扱¥310¥310Y450(内訳)簡易書留小計郵便物引受合計通数課税(内消費税等非課税言2通Y570¥42)Y0合計¥570¥1,000お預り金額おつリ¥430' }
    end
  end

  describe '#amount' do
    subject { receipt.amount }

    context 'when first image' do
      let(:source) { "#{RSPEC_ROOT}/fixtures/files/first_image.png" }

      it { is_expected.to eq nil }
    end

    context 'when second image' do
      let(:source) { "#{RSPEC_ROOT}/fixtures/files/second_image.png" }

      it { is_expected.to eq 570 }
    end
  end
end
