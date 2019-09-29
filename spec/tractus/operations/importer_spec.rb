# frozen_string_literal: true

RSpec.describe Tractus::Importer do
  let(:periods_filename) { 'level1_periods.json' }
  let(:path_prefix) { './spec/fixtures/' }
  let(:file_path) { path_prefix + periods_filename }
  context 'Periods subclass' do
    let(:subject) { described_class::Periods.call(path: file_path) }
    it 'open json file periods and create an array of Period objects' do
      expect(subject.count).to eq(3)
      expect(subject.sample).to be_kind_of(Tractus::Period)
    end
  end
end
