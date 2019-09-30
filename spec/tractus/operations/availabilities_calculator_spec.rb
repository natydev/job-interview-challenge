# frozen_string_literal: true

RSpec.describe Tractus::AvailabilitiesCalculator do
  let(:periods) { [double(Tractus::Period), double(Tractus::Period)] }
  let(:subject) { described_class.call(periods: periods) }
  context '.call' do
    it 'iterate periods and calculate each with AvailabilityCalculator' do
      allow(Tractus::AvailabilityCalculator)
        .to receive(:call) { periods.sample }
      expect(Tractus::AvailabilityCalculator).to receive(:call).twice
      subject
    end
  end
end
