# frozen_string_literal: true

RSpec.describe Tractus::DevAvailability do
  let(:period) do
    Tractus::Period.new(id: 1, since: '2019-01-01',
                        until: '2019-01-10')
  end
  let(:developer) do
    Tractus::Developer.new(id: 3, name: 'John Connor',
                           birth_on: '1970-01-01')
  end
  let(:availability) do
    Tractus::Availability.new(total_days: 365, workdays: 250,
                              weekend_days: 105, holidays: 10, period: period)
  end
  let!(:json_factories) do
    [
      { "period_id": 1, "total_days": 365, "workdays": 250,
        "weekend_days": 105, "holidays": 10 },
      { "period_id": 2, "total_days": 76,  "workdays": 51,
        "weekend_days": 22,  "holidays": 3 },
      { "period_id": 3, "total_days": 15,  "workdays": 11,
        "weekend_days": 4,   "holidays": 0 }
    ]
  end
  let(:json_factory) do
    json_factories.sample.merge(availability: availability,
                                developer: developer)
  end
  let(:subject) { described_class.new(json_factory) }
  context '#attributes' do
    it 'return an hash with all public attributes' do
      expect(subject.output).to eq(
        developer_id: developer.id,
        period_id: period.id,
        total_days: subject.total_days,
        workdays: subject.workdays,
        weekend_days: subject.weekend_days,
        holidays: subject.holidays
      )
    end
  end
  context 'increment' do
    it 'increment a numeric attribute by 1' do
      expect { subject.increment(:holidays) }
        .to change { subject.holidays }.by(1)
    end
    it 'increment a numeric attribute by specified number' do
      expect { subject.increment(:total_days, 3) }
        .to change { subject.total_days }.by(3)
    end
    it 'raises an error if specified number is less than 1' do
      expect { subject.increment(:workdays, -rand(0..3)) }
        .to raise_error(RangeError)
    end
  end
  context 'decrement' do
    it 'decrement a numeric attribute by 1' do
      expect { subject.decrement(:holidays) }
        .to change { subject.holidays }.by(-1)
    end
    it 'decrement a numeric attribute by specified number' do
      expect { subject.decrement(:total_days, 3) }
        .to change { subject.total_days }.by(-3)
    end
    it 'raises an error if specified number is less than 1' do
      expect { subject.decrement(:workdays, -rand(0..3)) }
        .to raise_error(RangeError)
    end
  end
end
