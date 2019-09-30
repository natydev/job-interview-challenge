# frozen_string_literal: true

RSpec.describe Tractus do
  let(:subject) { described_class.run_second_level(filename) }
  context '.run_second_level' do
    let(:filename) { 'level2-output-test.json' }
    let(:json_expected) do
      {
        "availabilities": [
          {
            "total_days": 365,
            "workdays": 248,
            "weekend_days": 105,
            "holidays": 12,
            "period_id": 1,
            "developer_id": 1
          },
          {
            "total_days": 365,
            "workdays": 249,
            "weekend_days": 105,
            "holidays": 11,
            "period_id": 1,
            "developer_id": 2
          },
          {
            "total_days": 365,
            "workdays": 248,
            "weekend_days": 105,
            "holidays": 12,
            "period_id": 1,
            "developer_id": 3
          },
          {
            "total_days": 76,
            "workdays": 51,
            "weekend_days": 22,
            "holidays": 3,
            "period_id": 2,
            "developer_id": 1
          },
          {
            "total_days": 76,
            "workdays": 51,
            "weekend_days": 22,
            "holidays": 3,
            "period_id": 2,
            "developer_id": 2
          },
          {
            "total_days": 76,
            "workdays": 50,
            "weekend_days": 22,
            "holidays": 4,
            "period_id": 2,
            "developer_id": 3
          },
          {
            "total_days": 15,
            "workdays": 11,
            "weekend_days": 4,
            "holidays": 0,
            "period_id": 3,
            "developer_id": 1
          },
          {
            "total_days": 15,
            "workdays": 11,
            "weekend_days": 4,
            "holidays": 0,
            "period_id": 3,
            "developer_id": 2
          },
          {
            "total_days": 15,
            "workdays": 10,
            "weekend_days": 4,
            "holidays": 1,
            "period_id": 3,
            "developer_id": 3
          }
        ]
      }.to_json
    end
    after(:each) do
      File.delete(filename)
    end

    it 'saves a JSON file with availabilities referred to periods' do
      subject
      json_to_test = JSON.parse(File.read(filename)).to_json
      expect(json_to_test)
        .to eq(json_expected)
    end
  end
end
