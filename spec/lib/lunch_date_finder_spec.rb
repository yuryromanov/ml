require 'rails_helper'

describe LunchDateFinder, type: :model do
  describe '#next_date' do
    subject { described_class.new(date).next_date }

    context 'for 9 Aug' do
      let(:date) { Date.parse('2020-08-09')}

      it { is_expected.to eq(Date.parse('2020-09-01'))}
    end

    context 'for 1 Feb' do
      let(:date) { Date.parse('2020-02-01')}

      # The first and second of March are days off
      it { is_expected.to eq(Date.parse('2020-03-03'))}
    end
  end
end
