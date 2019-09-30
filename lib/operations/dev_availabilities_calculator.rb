# frozen_string_literal: true

module Tractus
  # iterate an array of Availabily items and
  # sub-iterate array of Developer items, to build respective
  # DevAvailabilities objects belongs to a developer
  class DevAvailabilitiesCalculator
    include OperationShared
    initialize_with :availabilities, :developers

    def call
      availabilities.map do |availability|
        developers.map do |developer|
          DevAvailabilityCalculator
            .call(availability: availability,
                  developer: developer)
        end
      end.flatten
    end
  end
end
