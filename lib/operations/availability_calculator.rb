# frozen_string_literal: true

module Tractus
  # Create Ability from Period and calculate days attributes (weekends,
  # weekend_days, holidays, total_days), based on Period range since..until
  class AvailabilityCalculator
    extend Memoist
    include OperationShared
    initialize_with :period

    def availability
      Availability.new(period: period)
    end
    memoize :availability

    def call
      period.dates.each do |date|
        increment_attributes(Day.set(date))
      end
      availability
    end

    private

    def increment_attributes(day)
      availability.increment(:total_days)
      availability.increment(:workdays) if day.workday?
      availability.increment(:weekend_days) if day.weekend?
      availability.increment(:holidays) if day.holiday?
    end
  end
end
