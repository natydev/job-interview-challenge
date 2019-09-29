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

require './lib/operations/operation_shared'
require './lib/operations/importer'

# Top level application Tractus
module Tractus
end
