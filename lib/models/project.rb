# frozen_string_literal: true

module Tractus
  # Project is a subclass of Period object marshalling
  class Project < Period
    include ModelShared

    option :effort_days, Dry::Types['coercible.integer']
  end
end
