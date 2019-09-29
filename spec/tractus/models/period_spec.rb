# frozen_string_literal: true

RSpec.describe Tractus::Period do
  let!(:json_factories) do
    [
      { "id": 1, "since": '2017-01-01', "until": '2017-12-31' },
      { "id": 2, "since": '2017-03-17', "until": '2017-05-31' },
      { "id": 3, "since": '2017-05-17', "until": '2017-05-31' }
    ]
  end
  let(:json_factory) { json_factories.sample }
  let(:subject) { described_class.new(json_factory) }
  context '#attributes' do
    it 'return an hash with all attributes' do
      expect(subject.attributes).to eq(
        id: subject.id,
        since: subject.since,
        until: subject.until
      )
    end
  end
  context '#dates' do
    it 'return a range of dates between since and until date' do
      expect(subject.dates).to eq(subject.since..subject.until)
    end
  end
end
