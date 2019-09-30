# frozen_string_literal: true

RSpec.describe Tractus::Exporter do
  let!(:period1) do
    Tractus::Period.new("id": 1, "since": '2017-01-30', "until": '2017-10-30')
  end
  let!(:period2) do
    Tractus::Period.new("id": 2, "since": '2017-03-30', "until": '2017-04-30')
  end
  let(:subject) do
    described_class::Availabilities
      .call(items: items,
            filename: filename)
  end
  context 'Availabilities subclass' do
    let(:availability_1) do
      Tractus::Availability.new(period: period1,
                                total_days: 20,
                                workdays: 20,
                                weekend_days: 3,
                                holidays: 1)
    end
    let(:availability_2) do
      Tractus::Availability.new(period: period2,
                                total_days: 20,
                                workdays: 30,
                                weekend_days: 8,
                                holidays: 2)
    end
    let(:items) { [availability_1, availability_2] }
    let(:filename) { 'availabilities-test.json' }
    after(:each) do
      File.delete(filename)
    end
    it 'export Availability objects into JSON file' do
      subject
      json_to_test = JSON.parse(File.read(filename)).to_json
      json_expected = JSON.generate(
        described_class::Availabilities::WRAPPER =>
        [availability_1.output, availability_2.output]
      )
      expect(json_to_test)
        .to eq(json_expected)
    end
  end
end
