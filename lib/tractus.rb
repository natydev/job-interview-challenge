# frozen_string_literal: true

require 'json'
require 'date'
require 'memoist'
require 'dry-initializer'
require 'dry-types'
require 'holidays'
require 'smart_init'
require 'forwardable'

require './lib/models/model_shared'
require './lib/models/period'
require './lib/models/day'
require './lib/models/availability'
require './lib/models/developer'
require './lib/models/dev_availability'

require './lib/operations/operation_shared'
require './lib/operations/importer'
require './lib/operations/availability_calculator'
require './lib/operations/availabilities_calculator'
require './lib/operations/dev_availability_calculator'
require './lib/operations/exporter'

# Top level application Tractus
module Tractus
  def self.run_first_level(filename = 'level1-output.json')
    periods = Tractus::Importer::Periods.call(path: 'data.json')
    availabilities = Tractus::AvailabilitiesCalculator.call(periods: periods)
    Tractus::Exporter::Availabilities.call(items: availabilities,
                                           filename: filename)
  end
end
