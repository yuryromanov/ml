require 'rails_helper'

describe LunchDate, type: :model do

  describe '.upcoming' do
    subject { described_class.upcoming.first }

    context 'when db has 2 dates' do
      let!(:date1) { FactoryBot.create(:lunch_date, date: Date.parse('2020-06-01')) }
      let!(:date2) { FactoryBot.create(:lunch_date, date: Date.parse('2020-07-01')) }

      it { is_expected.to eq(date2) }
    end
  end

  describe '.last_3_months' do
    subject { described_class.last_3_months(Date.parse('2020-08-09')) }

    context 'when db has 4 dates in different months' do
      let!(:date1) { FactoryBot.create(:lunch_date, date: Date.parse('2020-04-01')) }
      let!(:date2) { FactoryBot.create(:lunch_date, date: Date.parse('2020-05-01')) }
      let!(:date3) { FactoryBot.create(:lunch_date, date: Date.parse('2020-06-01')) }
      let!(:date4) { FactoryBot.create(:lunch_date, date: Date.parse('2020-07-01')) }

      it 'returns 3 last months' do
        expect(subject.count).to eq(3)
      end
    end

    context 'when db has 4 dates the same month' do
      let!(:date1) { FactoryBot.create(:lunch_date, date: Date.parse('2020-07-01')) }
      let!(:date2) { FactoryBot.create(:lunch_date, date: Date.parse('2020-07-02')) }
      let!(:date3) { FactoryBot.create(:lunch_date, date: Date.parse('2020-07-03')) }
      let!(:date4) { FactoryBot.create(:lunch_date, date: Date.parse('2020-07-04')) }

      it 'returns all items' do
        expect(subject.count).to eq(4)
      end
    end
  end
end