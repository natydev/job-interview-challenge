# frozen_string_literal: true

RSpec.describe Tractus::ProAvailability do
  let(:period) do
    Tractus::Project.new(id: 1, since: '2019-01-01',
                         until: '2019-02-15', effort_days: 34)
  end
  let(:availability) do
    Tractus::Availability.new(total_days: 50, workdays: 40,
                              weekend_days: 6, holidays: 1, period: period)
  end
  let(:json_factory) do
    availability.attributes.merge(availability: availability)
  end
  let(:subject) { described_class.new(json_factory) }
  context '#output' do
    it 'return an hash with all public attributes' do
      expect(subject.output).to eq(
        period_id: period.id,
        total_days: subject.total_days,
        workdays: subject.workdays,
        weekend_days: subject.weekend_days,
        holidays: subject.holidays,
        feasibility: false
      )
    end
  end
  context 'feasibility' do
    it 'is true when team_workdays is greater than effort_days' do
      allow(subject).to receive(:team_workdays) { 35 }
      expect(subject).to be_feasibility
    end
    it 'is true when team_workdays is equal than effort_days' do
      allow(subject).to receive(:team_workdays) { 34 }
      expect(subject).to be_feasibility
    end
    it 'is false when team_workdays is less than effort_days' do
      allow(subject).to receive(:team_workdays) { 33 }
      expect(subject).to_not be_feasibility
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
