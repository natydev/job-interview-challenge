# frozen_string_literal: true

module Tractus
  # iterate an array of Periods to calculate respective Availabilities
  class AvailabilitiesCalculator
    include OperationShared
    initialize_with :periods

    def call
      periods.map do |period|
        AvailabilityCalculator.call(period: period)
      end
    end
  end
end
