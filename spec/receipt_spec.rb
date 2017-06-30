require 'spec_helper'

describe TryOcr::Receipt do
  let(:receipt) { TryOcr::Receipt.new(source) }

  describe '#text' do
    subject { receipt.text }

    context 'when first image' do
      let(:source) { "#{RSPEC_ROOT}/fixtures/files/first_image.png" }

      it { is_expected.to eq '日本語' }
    end
  end
end
