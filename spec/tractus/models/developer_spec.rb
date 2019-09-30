# frozen_string_literal: true

RSpec.describe Tractus::Developer do
  let!(:json_factories) do
    [
      { "id": 1, "name": 'Mi',   "birth_on": '1963-02-17' },
      { "id": 2, "name": 'Ti',   "birth_on": '1973-04-16' },
      { "id": 3, "name": 'Tony', "birth_on": '1983-05-17' }
    ]
  end
  let(:json_factory) { json_factories.sample }
  let(:subject) { described_class.new(json_factory) }
  context '#output' do
    it 'return an hash with all public attributes' do
      expect(subject.output).to eq(
        id: subject.id,
        name: subject.name,
        birth_on: subject.birth_on
      )
    end
  end
end
