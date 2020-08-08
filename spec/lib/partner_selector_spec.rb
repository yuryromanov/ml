require 'rails_helper'

describe PartnerSelector, type: :model do
  describe '#perform' do
    # e = employee
    let(:e1){ 1 }
    let(:e2){ 2 }
    let(:e3){ 3 }
    let(:e4){ 4 }
    let(:e5){ 5 }
    let(:e6){ 6 }
    # d = department
    let(:d1) { 1 }
    let(:d2) { 2 }
    let(:d3) { 3 }
    let(:departments) do
      {
        d1 => [e1],
        d2 => [e2],
        d3 => [e3, e4],
      }
    end
    let(:history) { [] }
    subject { described_class.new(employees, departments, history).perform }

    context 'for 2 employees' do
      let(:employees) { [e1, e2] }

      it { is_expected.to eq([[e1, e2]]) }
    end

    context 'for 3 employees' do
      let(:employees) { [e1, e2, e3] }

      it { is_expected.to eq([[e1, e2, e3]]) }
    end

    context 'for 4 employees' do
      let(:employees) { [e1, e2, e3, e4] }

      it { is_expected.to eq([[e1, e2], [e3, e4]]) }

      context 'when e1 and e2 were partners' do
        let(:history) { [[e1, e2]] }

        it { is_expected.to eq([[e1, e3], [e2, e4]]) }
      end

      context 'when e2 and e3 were partners' do
        let(:history) { [[e2, e3]] }

        it { is_expected.to eq([[e1, e2], [e3, e4]]) }
      end

      # edge case!
      context 'when e3 and e4 were partners' do
        let(:history) { [[e3, e4]] }

        it { is_expected.to eq([[e1, e2], [e3, e4]]) }
      end
    end

    context 'for 5 employees' do
      let(:employees) { [e1, e2, e3, e4, e5] }

      it { is_expected.to eq([[e1, e2], [e3, e4, e5]]) }

      context 'when e1 and e2 were partners' do
        let(:history) { [[e1, e2]] }

        it { is_expected.to eq([[e1, e3], [e2, e4, e5]]) }
      end

      context 'when [e1, e2] and [e1, e3] were partners' do
        let(:history) { [[e1, e2], [e1, e3]] }

        it { is_expected.to eq([[e1, e4], [e2, e3, e5]]) }
      end

      context 'when e3 and e4 were partners' do
        let(:history) { [[e3, e4]] }

        it { is_expected.to eq([[e1, e2], [e3, e5, e4]]) }
      end
    end

    context 'for 6 employees' do
      let(:employees) { [e1, e2, e3, e4, e5, e6] }

      it { is_expected.to eq([[e1, e2], [e3, e4], [e5, e6]]) }

      context 'when e1 and e2 were partners' do
        let(:history) { [[e1, e2]] }

        it { is_expected.to eq([[e1, e3], [e2, e4], [e5, e6]]) }
      end

      context 'when e1, e2 and e3 were partners' do
        let(:history) { [[e1, e2, e3]] }

        it { is_expected.to eq([[e1, e4], [e2, e5], [e3, e6]]) }
      end

      context 'when [e1, e2], [e1, e3] were partners' do
        let(:history) { [[e1, e2], [e1, e3]] }

        it { is_expected.to eq([[e1, e4], [e2, e3], [e5, e6]]) }
      end

      context 'when [e1, e2], [e1, e3], [e1, e4] were partners' do
        let(:history) { [[e1, e2], [e1, e3], [e1, e4]] }

        it { is_expected.to eq([[e1, e5], [e2, e3], [e4, e6]]) }
      end
    end
  end
end
