require 'rails_helper'

describe LunchCreator, type: :model do
  describe '#perform' do
    let(:date) { nil }
    subject{ described_class.new(date).perform }

    context 'when date is nil' do
      it 'creates new lunch with date in next month' do
        subject

        expect(LunchDate.last.date).to eq(LunchDateFinder.new(Date.current).next_date)
      end
    end

    context 'when date is 1 Apr' do
      let(:date) { Date.parse('2020-04-01') }

      it 'creates new lunch with date 2020-05-01' do
        subject

        expect(LunchDate.last.date).to eq(Date.parse('2020-04-01'))
      end
    end

    context 'when LunchPartnerSelector returns stubbed result' do
      let(:result) do
        [
          [FactoryBot.create(:employee), FactoryBot.create(:employee)],
          [FactoryBot.create(:employee), FactoryBot.create(:employee), FactoryBot.create(:employee)],
        ]
      end
      before do
        expect_any_instance_of(LunchPartnerSelector).to receive(:perform).and_return(result)
      end

      specify do
        subject

        expect(MysteryLunch.count).to eq(2)
        expect(MysteryLunch.first.lunch_partners.count).to eq(2)
        expect(MysteryLunch.last.lunch_partners.count).to eq(3)
      end
    end
  end
end
