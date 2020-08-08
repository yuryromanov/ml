require 'rails_helper'

describe HistoryChecker, type: :model do
  describe '#none?' do
    # e = employee
    let(:e1){ 1 }
    let(:e2){ 2 }
    let(:e3){ 3 }
    let(:e4){ 4 }
    let(:history) { [] }
    subject { described_class.new(history).none?(e1, e2) }

    it { is_expected.to eq(true) }

    context 'when employee is in history' do
      let(:history) { [[e1, e2]] }

      it { is_expected.to eq(false) }
    end

    context 'when employee is not in history' do
      let(:history) { [[e1, e3], [e1, e4]] }

      it { is_expected.to eq(true) }
    end

    context 'when employee is not in history' do
      let(:history) { [[e2, e3, e4]] }

      it { is_expected.to eq(true) }
    end
  end
end
