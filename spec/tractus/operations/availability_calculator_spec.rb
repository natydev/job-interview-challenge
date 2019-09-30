# frozen_string_literal: true

RSpec.describe Tractus::AvailabilityCalculator do
  let(:period) do
    Tractus::Period.new(id: 1, since: '2019-01-01',
                        until: '2019-01-10')
  end
  let(:subject) { described_class.call(period: period) }
  context '.call' do
    context 'set attributes based on days between since and until attributes' do
      it 'total_days equals all days between since and until' do
        expect(subject.total_days).to eq(10)
      end
      it 'workdays equal to some working days' do
        expect(subject.workdays).to eq(7)
      end
      it 'weekend_days equal to some weekend days' do
        expect(subject.weekend_days).to eq(2)
      end
      it 'holidays equal to some holidays' do
        expect(subject.holidays).to eq(1)
      end
    end
  end
end
