require 'rails_helper'

describe Employee, type: :model do

  ['first_name', 'last_name'].each do |field|
    describe "##{field}" do
      let(:employee) { FactoryBot.build_stubbed(:employee) }

      context 'with empty value' do
        before { employee.send("#{field}=", '') }

        it { expect(employee).to be_invalid }
      end

      context 'with length 256 character' do
        before { employee.send("#{field}=", 'a' * 256) }

        it { expect(employee).to be_invalid }
      end
    end
  end

  describe "email" do
    let(:email) { 'aaa@bbb.com' }
    let!(:employee1) { FactoryBot.create(:employee, email: email) }

    context 'for another employee with the same email' do
      let(:employee2) { FactoryBot.build(:employee, email: email) }

      it { expect(employee2).to be_invalid }
    end
  end
end
