# frozen_string_literal: true

RSpec.describe Tractus::DevAvailabilityCalculator do
  let!(:json_period_factory) do
    { "id": 1, "since": '2019-01-01', "until": '2019-12-31' }
  end
  let!(:period) { Tractus::Period.new(json_period_factory) }
  let!(:json_developer_factories) do
    [
      { "id": 1, "name": 'Mi',   "birth_on": '1963-02-19' },
      { "id": 2, "name": 'Ti',   "birth_on": '1973-04-14' },
      { "id": 3, "name": 'Tony', "birth_on": '1983-06-02' }
    ]
  end
  let(:developer) { Tractus::Developer.new(json_developer_factory) }
  let(:json_availability_factory) do
    {
      "total_days": 365, "workdays": 250,
      "weekend_days": 105, "holidays": 10
    }.merge("period": period)
  end
  let(:availability) do
    Tractus::Availability.new(
      json_availability_factory
    )
  end
  let(:subject) do
    described_class.call(developer: developer,
                         availability: availability)
  end
  context '#attributes' do
    context 'when dev birthday is in weekend' do
      let!(:json_developer_factory) { json_developer_factories[1] }
      it 'return an object DevAvailability' \
      ' with same workdays of related Availability' do
        expect(subject.output).to eq(
          period_id: period.id,
          developer_id: developer.id,
          total_days: availability.total_days,
          workdays: availability.workdays,
          weekend_days: availability.weekend_days,
          holidays: availability.holidays
        )
      end
    end
    context 'when dev birthday is in workday' do
      let!(:json_developer_factory) { json_developer_factories[0] }
      it 'return workdays attribute decreased by 1' do
        expect(subject.workdays)
          .to eq(availability.workdays - 1)
      end
      it 'return holidays attribute increased by 1' do
        expect(subject.holidays)
          .to eq(availability.holidays + 1)
      end
    end
    context 'when dev birthday is in holiday' do
      let!(:json_developer_factory) { json_developer_factories[2] }
      it 'return same workdays' do
        expect(subject.workdays)
          .to eq(availability.workdays)
      end
      it 'return same holidays' do
        expect(subject.holidays)
          .to eq(availability.holidays)
      end
    end
  end
end
