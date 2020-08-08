require 'rails_helper'

describe LunchPartnerSelector, type: :model do
  describe '#perform' do
    # e = employee
    let(:e1){ FactoryBot.build_stubbed(:employee, id: 1, department_id: 1) }
    let(:e2){ FactoryBot.build_stubbed(:employee, id: 2, department_id: 2) }
    let(:e3){ FactoryBot.build_stubbed(:employee, id: 3, department_id: 3) }
    let(:e4){ FactoryBot.build_stubbed(:employee, id: 4, department_id: 4) }
    let(:e5){ FactoryBot.build_stubbed(:employee, id: 5, department_id: 5) }
    let(:e6){ FactoryBot.build_stubbed(:employee, id: 6, department_id: 6) }
    let(:history) { [] }
    subject { described_class.new(employees, history).perform }

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

      context 'when e1, e2 and e3, e4 are in the same department' do
        before do
          e2.department_id = e1.department_id
          e4.department_id = e3.department_id
        end

        it { is_expected.to eq([[e1, e3], [e2, e4]]) }
      end

      context 'when e1 and e2 were partners' do
        let(:history) { [[e1.id, e2.id]] }

        it { is_expected.to eq([[e1, e3], [e2, e4]]) }
      end

      context 'when e2 and e3 were partners' do
        let(:history) { [[e2.id, e3.id]] }

        it { is_expected.to eq([[e1, e2], [e3, e4]]) }
      end

      # edge case #1
      context 'when e3 and e4 were partners' do
        let(:history) { [[e3.id, e4.id]] }

        it { is_expected.to eq([[e1, e2], [e4, e3]]) }
      end

      # edge case #2
      context 'when all people were partners' do
        let(:history) { [[e1.id, e2.id, e3.id, e4.id]] }

        it { is_expected.to eq([[e2, e1], [e3, e4]]) }
      end

    end

    context 'for 5 employees' do
      let(:employees) { [e1, e2, e3, e4, e5] }

      it { is_expected.to eq([[e1, e2, e5], [e3, e4]]) }

      context 'when e1 and e2 were partners' do
        let(:history) { [[e1.id, e2.id]] }

        it { is_expected.to eq([[e1, e3, e5], [e2, e4]]) }
      end

      context 'when [e1, e2] and [e1, e3] were partners' do
        let(:history) { [[e1.id, e2.id], [e1.id, e3.id]] }

        it { is_expected.to eq([[e1, e4, e5], [e2, e3]]) }
      end

      context 'when e3 and e4 were partners' do
        let(:history) { [[e3.id, e4.id]] }

        it { is_expected.to eq([[e1, e2, e4], [e3, e5]]) }

        context 'and e1 and e4 have the same department' do
          before { e4.department_id = e1.department_id }

          it { is_expected.to eq([[e1, e2], [e3, e5, e4]]) }
        end
      end
    end

    context 'for 6 employees' do
      let(:employees) { [e1, e2, e3, e4, e5, e6] }

      it { is_expected.to eq([[e1, e2], [e3, e4], [e5, e6]]) }

      context 'when e1 and e2 were partners' do
        let(:history) { [[e1.id, e2.id]] }

        it { is_expected.to eq([[e1, e3], [e2, e4], [e5, e6]]) }
      end

      context 'when e1, e2 and e3 were partners' do
        let(:history) { [[e1.id, e2.id, e3.id]] }

        it { is_expected.to eq([[e1, e4], [e2, e5], [e3, e6]]) }
      end

      context 'when [e1, e2], [e1, e3] were partners' do
        let(:history) { [[e1.id, e2.id], [e1.id, e3.id]] }

        it { is_expected.to eq([[e1, e4], [e2, e3], [e5, e6]]) }
      end

      context 'when [e1, e2], [e1, e3], [e1, e4] were partners' do
        let(:history) { [[e1.id, e2.id], [e1.id, e3.id], [e1.id, e4.id]] }

        it { is_expected.to eq([[e1, e5], [e2, e3], [e4, e6]]) }
      end
    end
  end
end
