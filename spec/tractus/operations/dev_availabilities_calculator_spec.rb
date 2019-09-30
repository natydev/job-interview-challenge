# frozen_string_literal: true

RSpec.describe Tractus::DevAvailabilitiesCalculator do
  let(:availabilities) do
    [spy(Tractus::Availability),
     spy(Tractus::Availability)]
  end
  let(:developers) do
    [spy(Tractus::Developer),
     spy(Tractus::Developer)]
  end
  let(:subject) do
    described_class.call(availabilities: availabilities,
                         developers: developers)
  end
  context '.call' do
    it 'iterate availabilities and calculate each with' \
    ' DevAvailabilityCalculator' do
      allow(Tractus::DevAvailabilityCalculator)
        .to receive(:call)
      expect(Tractus::DevAvailabilityCalculator).to receive(:call)
        .exactly(4).times
      subject
    end
  end
end
