# frozen_string_literal: true

require 'json'
require 'date'
require 'memoist'
require 'dry-initializer'
require 'dry-types'
require 'holidays'
require 'smart_init'

require './lib/models/model_shared'
require './lib/models/period'
require './lib/models/day'
require './lib/models/availability'

require './lib/operations/operation_shared'
require './lib/operations/importer'
require './lib/operations/availability_calculator'
require './lib/operations/availabilities_calculator'

# Top level application Tractus
module Tractus
end
