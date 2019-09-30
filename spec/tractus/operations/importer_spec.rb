# frozen_string_literal: true

RSpec.describe Tractus::Importer do
  let(:path_prefix) { './spec/fixtures/' }
  let(:file_path) { path_prefix + filename }
  context 'Periods subclass' do
    let(:filename) { 'level1_periods.json' }
    let(:subject) { described_class::Periods.call(path: file_path) }
    it 'open json file periods and create an array of Period objects' do
      expect(subject.count).to eq(3)
      expect(subject.sample).to be_kind_of(Tractus::Period)
    end
  end
  context 'Developers subclass' do
    let(:filename) { 'level2_developers.json' }
    let(:subject) { described_class::Developers.call(path: file_path) }
    it 'open json file developers and create an' \
    ' array of Developer objects' do
      expect(subject.count).to eq(3)
      expect(subject.sample).to be_kind_of(Tractus::Developer)
    end
  end
end
