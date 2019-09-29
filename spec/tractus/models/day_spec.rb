# frozen_string_literal: true

RSpec.describe Tractus::Day do
  let!(:workdays_strings) do
    %w[
      2019-03-04 2019-02-19 2019-04-17 2019-07-18 2019-05-10
    ]
  end
  let(:workday_date) { Date.parse(workdays_strings.sample) }
  let(:weekend_strings) do
    %w[2019-01-13 2019-08-17]
  end
  let(:weekend_date) { Date.parse(weekend_strings.sample) }
  let!(:holiday_on_workday_strings) do
    %w[2019-05-01 2020-06-02 2019-11-01]
  end
  let(:holiday_on_workday_date) do
    Date.parse(holiday_on_workday_strings.sample)
  end
  let!(:holiday_on_weekend_strings) do
    %w[2019-01-06 2019-06-02 2021-05-01]
  end
  let(:holiday_on_weekend_date) do
    Date.parse(holiday_on_weekend_strings.sample)
  end
  let(:subject) { described_class.set(selected_date) }
  context 'with invalid data' do
    it 'returns specific error' do
      expect { described_class.set('hello') }
        .to raise_error(Dry::Types::CoercionError)
    end
  end
  context '#workday?' do
    context 'when provided date is in workday range' do
      let!(:selected_date) { workday_date }
      it 'returns true' do
        expect(subject).to be_workday
      end
    end
    context 'when provided date is in weekend range' do
      let!(:selected_date) { weekend_date }
      it 'returns false' do
        expect(subject).to_not be_workday
      end
    end
  end
  context '#weekend?' do
    context 'when provided date is in weekend range' do
      let!(:selected_date) { weekend_date }
      it 'returns true' do
        expect(subject).to be_weekend
      end
    end
    context 'when provided date is in workday range' do
      let!(:selected_date) { workday_date }
      it 'returns false' do
        expect(subject).to_not be_weekend
      end
    end
  end
  context '#holiday?' do
    context 'when provided date is a holiday in workday range' do
      let!(:selected_date) { holiday_on_workday_date }
      it 'returns true' do
        expect(subject).to be_holiday
      end
    end
    context 'when provided date is a holiday in weekend range' do
      let!(:selected_date) { holiday_on_weekend_date }
      it 'returns false' do
        expect(subject).to_not be_holiday
      end
    end
    context 'when provided date is in workday range but not an holiday' do
      let!(:selected_date) { workday_date }
      it 'returns false' do
        expect(subject).to_not be_holiday
      end
    end
  end
end
