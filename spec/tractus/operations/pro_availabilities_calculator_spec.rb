# frozen_string_literal: true

RSpec.describe Tractus::ProAvailabilitiesCalculator do
  let!(:project) do
    Tractus::Project.new(id: 1, since: '2019-01-01',
                         until: '2019-12-31', effort_days: 23)
  end
  let(:availability) do
    Tractus::Availability.new(total_days: 50, workdays: 40,
                              weekend_days: 6, holidays: 1, period: project)
  end
  let(:developer_1) do
    Tractus::Developer.new(id: 1, name: 'Mi',
                           birth_on: '1963-02-19')
  end
  let(:developer_2) do
    Tractus::Developer.new(id: 2, name: 'Ti',
                           birth_on: '1973-04-23')
  end
  let(:availability) do
    Tractus::Availability.new(
      period: project, total_days: 365, workdays: 250,
      weekend_days: 105, holidays: 10
    )
  end
  let(:dev_availability_1) do
    Tractus::DevAvailability.new(
      availability: availability, developer: developer_1, total_days: 365,
      workdays: 249, weekend_days: 105, holidays: 11
    )
  end
  let(:dev_availability_2) do
    Tractus::DevAvailability.new(
      availability: availability, developer: developer_2, total_days: 365,
      workdays: 249, weekend_days: 105, holidays: 11
    )
  end
  let(:subject) do
    described_class.call(
      dev_availabilities: [dev_availability_1, dev_availability_2]
    )
  end
  context '.call' do
    it 'iterate groped dev_availabilities to abtain' \
    ' calculated array of Tractus::ProAvailability objects' do
      expect(subject.first).to be_kind_of(Tractus::ProAvailability)
    end
  end
end
