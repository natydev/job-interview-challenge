# frozen_string_literal: true

RSpec.describe Tractus::Availability do
  let!(:period) do
    Tractus::Period.new("id": 1, "since": '2017-01-01', "until": '2017-12-31')
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
  let(:json_factory) { json_factories.sample.merge(period: period) }
  let(:subject) { described_class.new(json_factory) }
  context '#output' do
    it 'return an hash with all attributes' do
      expect(subject.output).to eq(
        period_id: period.id,
        total_days: subject.total_days,
        workdays: subject.workdays,
        weekend_days: subject.weekend_days,
        holidays: subject.holidays
      )
    end
  end
  context 'increment' do
    it 'increment a numeric attribute by 1 (if 2nd argument' \
       ' not specified)' do
      expect { subject.increment(:holidays) }
        .to change { subject.holidays }.by(1)
    end
    it 'increment a numeric attribute by specified number' do
      expect { subject.increment(:total_days, 3) }
        .to change { subject.total_days }.by(3)
    end
  end
end
