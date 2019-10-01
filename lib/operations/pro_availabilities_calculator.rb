# frozen_string_literal: true

module Tractus
  # group an array of DevAvailabily items and
  # iterate each resulted hash "project => dev_availabilities"
  # to build respective ProAvailability objects having
  # the calculated sum of all developers workdays.
  class ProAvailabilitiesCalculator
    include OperationShared
    initialize_with :dev_availabilities

    def call
      team_availabilities.map do |_project, dev_availabilities|
        availability = pick_availability(dev_availabilities)
        Tractus::ProAvailability.new(
          availability.attributes.merge(
            team_workdays: sum_workdays(dev_availabilities),
            availability: availability
          )
        )
      end
    end

    private

    def pick_availability(dev_availabilities)
      dev_availabilities.first.send(:availability)
    end

    def sum_workdays(dev_availabilities)
      dev_availabilities.sum(&:workdays)
    end

    def team_availabilities
      dev_availabilities.group_by(&:availability_period)
    end
  end
end
